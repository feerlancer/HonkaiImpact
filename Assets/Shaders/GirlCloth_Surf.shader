//!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
Shader "HonKai/GirlCloth_Surf" //!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
{
//!!!!!compute in GAMMA Space !!!!!!!!!!!!!!!!!!!!!!!
	Properties
	{
		//texture
		_MainTex ("MainTex", 2D) = "white" {}
		_LightMapTex ("LightMap", 2D) = "white"{}
		_BloomMaskTex("BloomMap",2D)="white"{}
		_FirstShadowMultColor("FirstShadowMultColor",Vector) = (0.73, 0.6, 0.65,0)
		_SecondShadowMultColor("SecondShadowMultColor",Vector) = (0.65, 0.45, 0.55,0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGPROGRAM

//#		define NO_SPECULAR
//#		define NO_SECOND_SHADOW
		#include "UnityCG.cginc"
		#pragma surface surf KonkaiCloth  noambient
		bool4 notEqual(float4 a, float4 b)
		{
			return bool4(a.x!=b.x,a.y!=b.y,a.z!=b.z,a.w!=b.w);
		}
		bool4 greaterThanEqual(float4 a, float4 b)
		{
			return bool4(a.x>=b.x,a.y>=b.y,a.z>=b.z,a.w>=b.w);
		}

		sampler2D _MainTex;
		sampler2D _LightMapTex;
		sampler2D _BloomMaskTex;

		const static float _UsingDitherAlpha = 0;
		const static float _DitherAlpha = 1;
		const static float _UsingBloomMask = 0;
		uniform float4 _BloomMaskTex_ST;

		//uniforms
		const static half4 _Color = half4(0.93, 0.93, 0.93, 0.95); //lightColor
		const static half _FirstShadowArea = 0.51; // _LightArea
		const static half _SecondShadowArea = 0.51; // _SecondShadow
		//const static half3 _FirstShadowMultColor = half3(0.73, 0.6, 0.65);
		//const static half3 _SecondShadowMultColor = half3(0.65, 0.45, 0.55);
		uniform half3 _FirstShadowMultColor;
		uniform half3 _SecondShadowMultColor;
		const static half _Shininess = 10;
		const static half _SpecMulti = 0.2;
		const static half3 _LightSpecColor = half3(1, 1, 1);
		const static half _BloomFactor = 1;
		const static half _Emission = 1;
		const static half _EmissionBloomFactor = 0;

		struct Input
		{
			float3 viewDir;
			float4 vs_COLOR0:COLOR0;
			float3 worldPos;
			float3 worldNormal;
			float2 uv_MainTex;
		};

		half4 vs_COLOR0;
		half2 vs_UV;
	    float2 bloomUV;
	    half2 vs_TEXCOORD5;
	    float3 vs_worldPos;
		half4 LightingKonkaiCloth(SurfaceOutput s,half3 lightDir, half3 viewDir, half atten)
		{

			half4 SV_Target0;

			half3 N= normalize(s.Normal);
			half3 L =  normalize(lightDir);

			half half_NdotL = dot(N, L)*0.5 + 0.5;//[-1,1]->[0,1]

			float4 ClipPos = mul(UNITY_MATRIX_VP,float4(vs_worldPos,1));
			ClipPos.y*=_ProjectionParams.x;
			ClipPos.xy = 0.5* (ClipPos.ww + ClipPos.xy);//[-w,w]->[0,w]

			//float4 vs_ClipPosFrom0ToW;
		 //   vs_ClipPosFrom0ToW.xyw = _UsingDitherAlpha?ClipPos.xyw:0;
		 //   vs_ClipPosFrom0ToW.z = _UsingDitherAlpha ? _DitherAlpha : 0;

			fixed4 mainColor = tex2D(_MainTex, vs_UV.xy);

			half mainTexColorAlpha;
		    if(_UsingBloomMask){
				fixed bloomMask = tex2D(_BloomMaskTex, vs_TEXCOORD5.xy).x;
		        mainTexColorAlpha = mainColor.w * bloomMask;

		    } else {
		        mainTexColorAlpha = mainColor.w;
		    }
		//    if(_UsingDitherAlpha){
		//    	bool IsditherAlphaSmallEnough;
		//#ifdef UNITY_ADRENO_ES3
		//        IsditherAlphaSmallEnough = !!(vs_ClipPosFrom0ToW.z<0.949999988);
		//#else
		//		IsditherAlphaSmallEnough = (vs_ClipPosFrom0ToW.z<0.949999988);
		//#endif
		//        if(IsditherAlphaSmallEnough){
		//				//TODO
		//        }
		//    }

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
		    shadowFactor1 = shadowFactor1 * 0.5 -_FirstShadowArea + 1.0;
			//最后得到第一层阴影
			float3 finalDiffuse = shadowFactor1 >= 1? mainColor.xyz : firstShadow.xyz;
#ifndef NO_SECOND_SHADOW
			//calculate second shadow
			float3 secondShadow = mainColor.xyz * _SecondShadowMultColor.xyz;
			//阴影Mask和顶点色决定是否要第二层阴影
			if (vs_COLOR0.x * shadowMask + 0.91 < 1)
			{
				//use first or second shadow
				//阴影Mask、顶点色、光线与法线夹角决定第二层阴影程度
				float shadowResult = vs_COLOR0.x * shadowMask + half_NdotL;
				//调节第二层阴影范围
				float shadowFactor2 = 0.5*shadowResult-_SecondShadowArea + 1.0;
				//最后得到第二层阴影
				finalDiffuse = shadowFactor2 >=1? firstShadow : secondShadow;
			}
#endif

			//caculate Spec
			float3 V = normalize(viewDir);
			float3 H = normalize(V + L);
			float NdotH = max(0,dot(N, H));
			//半角向量和光泽度得出高光系数
		    float specDiff = exp2(log2(NdotH) * _Shininess);
			//取得高光强度
			float objSpec_Intensity = lightMapColor.x;
			//取得高光mask
			float objSpec_Mask = lightMapColor.z;
			//根据高光Mask和高光系数判断是否需要高光
			bool needSpec = (1.0 - objSpec_Mask  - specDiff) > 0.0;
			//计算高光颜色
		    float3 lightSpec = _SpecMulti * _LightSpecColor.xyz * objSpec_Intensity;
		    float3 finalSpec = needSpec ? 0.0 : lightSpec;

			float3 finalColor = finalDiffuse.xyz *_Color.xyz;
#ifndef NO_SPECULAR
			finalColor += finalSpec.xyz *_Color.xyz;
#endif
			//float3 finalColor = (finalDiffuse.xyz + finalSpec) * _Color.xyz;

			float lightalphaWithBloom = _Color.w * _BloomFactor;
			float4 u_xlat16_0;
		    u_xlat16_0.xyz = mainColor.xyz * _Emission -finalColor.xyz;
		    u_xlat16_0.w = -_BloomFactor * _Color.w + _EmissionBloomFactor;
		    SV_Target0 = mainTexColorAlpha * u_xlat16_0 + float4(finalColor.xyz,lightalphaWithBloom);


		    SV_Target0.xyz*=atten;

		    return SV_Target0;
		}

		void surf(Input IN,inout SurfaceOutput o)
		{
			vs_COLOR0 = IN.vs_COLOR0;

			vs_UV= half2(IN.uv_MainTex.x,1-IN.uv_MainTex.y);

		    bloomUV = IN.uv_MainTex.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;

		    vs_TEXCOORD5 = _UsingBloomMask ? bloomUV : 0.0;

			vs_worldPos= IN.worldPos;
		}
		ENDCG
	}
}
