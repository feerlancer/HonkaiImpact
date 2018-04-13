// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

//!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
Shader "HonKai/GirlSkin_Surf" //!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
{
	//!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
	Properties
	{
		//texture
		_MainTex("MainTex", 2D) = "white" {}
		_LightMapTex("LightMap", 2D) = "white"{}
		_FirstShadowMultColor("FirstShadowMultColor",Vector) = (0.9215686, 0.7686275, 0.8)
		_SecondShadowMultColor("SecondShadowMultColor",Vector) = (0.8313726, 0.6, 0.5882353)
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		CGPROGRAM
//#		define NO_SECOND_SHADOW
//#		define NO_SPECULAR

		#include "UnityCG.cginc"
		#pragma surface surf KonKaiSkin  noambient// nolightmap// noambient addshadow
			bool4 notEqual(float4 a, float4 b)
		{
			return bool4(a.x != b.x,a.y != b.y,a.z != b.z,a.w != b.w);
		}
		bool4 greaterThanEqual(float4 a, float4 b)
		{
			return bool4(a.x >= b.x,a.y >= b.y,a.z >= b.z,a.w >= b.w);
		}

		sampler2D _MainTex;
		sampler2D _LightMapTex;

		//uniforms
		const static half4 _Color = half4(0.9313725, 0.9313725, 0.9313725, 0.95);//lightColor
		const static half _FirstShadowArea = 0.51; // _LightArea
		const static half _SecondShadowArea = 0.51; // _SecondShadow
		uniform half3 _FirstShadowMultColor;
		uniform half3 _SecondShadowMultColor;
		const static half _Shininess = 10;
		const static half _SpecMulti = 0.2;
		const static half3 _LightSpecColor = half3(1, 1, 1);
		const static half _BloomFactor = 1;
		const static fixed _lightProbToggle = 0;
		const static half4 _lightProbColor = half4(0, 0, 0, 0);

		struct Input
		{
			float4 vs_COLOR0:COLOR0;
			float3 worldPos;
			float3 worldNormal;
			float2 uv_MainTex;
		};

		half4 vs_COLOR0;
		half2 vs_UV;
		float3 vs_worldPos;
		half4 LightingKonKaiSkin(SurfaceOutput s,half3 lightDir, half3 viewDir, half atten)
		{

			half4 SV_Target0;

			//in
			half3 N = normalize(s.Normal);
			half3 L = normalize(lightDir);

			float NdotL = dot(N,L);
			NdotL = NdotL*0.5 + 0.5;//[-1,1]->[0,1]
			half half_NdotL = NdotL;


			float4 ClipPos = mul(UNITY_MATRIX_VP,float4(vs_worldPos,1));
			ClipPos.y *= _ProjectionParams.x;
			ClipPos.xy = 0.5* (ClipPos.ww + ClipPos.xy);//[-w,w]->[0,w]
			fixed4 mainColor = tex2D(_MainTex, vs_UV.xy);

			half mainTexColorAlpha = mainColor.w;
			fixed3 lightMapColor = tex2D(_LightMapTex, vs_UV.xy).xyz;
			float shadowMask = lightMapColor.y;
			//calculate first shadow
			float3 firstShadow = mainColor.xyz * _FirstShadowMultColor.xyz;
			//阴影Mask和顶点色计算得到阴影程度
			float shadowFactor1;
			if (vs_COLOR0.x * shadowMask <= 0.5)
				shadowFactor1 = shadowMask * vs_COLOR0.x * 1.25 - 0.125;
			else
				shadowFactor1 = shadowMask * vs_COLOR0.x * 1.2 - 0.1;
			//加入光线与法线夹角
			shadowFactor1 += half_NdotL;
			//调节第一层阴影范围
			shadowFactor1 = shadowFactor1 * 0.5 - _FirstShadowArea + 1.0;
			//最后得到第一层阴影
			float3 finalDiffuse = shadowFactor1 >= 1 ? mainColor.xyz : firstShadow.xyz;

			//calculate second shadow
			float3 secondShadow = mainColor.xyz * _SecondShadowMultColor.xyz;
	#ifndef NO_SECOND_SHADOW
			//阴影Mask和顶点色决定是否要第二层阴影
			if (vs_COLOR0.x * shadowMask + 0.91 < 1)
			{
				//use first or second shadow
				//阴影Mask、顶点色、光线与法线夹角决定第二层阴影程度
				float shadowResult = vs_COLOR0.x * shadowMask + half_NdotL;
				//调节第二层阴影范围
				float shadowFactor2 = 0.5*shadowResult - _SecondShadowArea + 1.0;
				//最后得到第二层阴影
				finalDiffuse = shadowFactor2 >=1? firstShadow : secondShadow;
			}
	#endif
			//caculate Spec
			float3 V = normalize(viewDir);
			float3 H = normalize(V + L);
			float NdotH = max(0, dot(N, H));
			float specDiff = exp2(log2(NdotH) * _Shininess);
			float objSpec_Intensity = lightMapColor.x;
			float objSpec_Threshold = lightMapColor.z;
			bool needSpec = (1.0 - objSpec_Threshold - specDiff) > 0.0;
			float3 lightSpec = _SpecMulti * _LightSpecColor.xyz * objSpec_Intensity;
			float3 finalSpec = needSpec ? 0.0 : lightSpec;

			float3 finalColor = finalDiffuse.xyz *_Color.xyz;
#ifndef NO_SPECULAR
			finalColor += finalSpec.xyz *_Color.xyz;
#endif
			//float3 finalColor = (finalDiffuse.xyz + finalSpec) * _Color.xyz;

			half3 lightProbColor = 0.5<_lightProbToggle ? _lightProbColor.xyz : 1.0;
			SV_Target0.xyz = finalColor * lightProbColor;
			SV_Target0.w = _BloomFactor;

			SV_Target0.xyz *= atten;

			return SV_Target0;
		}

		void surf(Input IN,inout SurfaceOutput o)
		{
			vs_COLOR0 = IN.vs_COLOR0;

			vs_UV = half2(IN.uv_MainTex.x,1 - IN.uv_MainTex.y);

			vs_worldPos = IN.worldPos;
		}
		ENDCG
	}

}
