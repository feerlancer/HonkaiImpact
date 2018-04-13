Shader "HonKai/GirlEye2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" } 
		LOD 100
		ColorMask A
		Cull Off
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			
			uniform 	float4 _MainTex_ST;
			uniform 	float4 _BloomMaskTex_ST;
			static const half _BloomFactor=1;
			uniform		sampler2D _MainTex;
			struct appdata
			{
				float4 in_POSITION0 : POSITION;
				float4 in_TEXCOORD0 : TEXCOORD0;
			};

			struct v2f
			{
				float2 vs_TEXCOORD0 : TEXCOORD0;
				half2 vs_TEXCOORD2 : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.in_POSITION0);
				o.vs_TEXCOORD0 = TRANSFORM_TEX(v.in_TEXCOORD0, _MainTex);
				o.vs_TEXCOORD0.y = 1 - o.vs_TEXCOORD0.y;
				o.vs_TEXCOORD2 = TRANSFORM_TEX(v.in_TEXCOORD0, _BloomMaskTex);
				o.vs_TEXCOORD2.y = 1 - o.vs_TEXCOORD2.y;
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;

				float u_xlat0;
				fixed u_xlat10_0;
				bool u_xlatb0;

				u_xlat10_0 = tex2D(_MainTex, i.vs_TEXCOORD0.xy).w;
				u_xlat0 = u_xlat10_0 + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(u_xlat0<0.0);
#else
				u_xlatb0 = u_xlat0<0.0;
#endif
				if ((int(u_xlatb0) * int(0xffffffffu)) != 0) { discard; }
				SV_Target0.xyz = float3(0.0, 0.0, 0.0);
				SV_Target0.w = _BloomFactor;
				return SV_Target0;
			}
			ENDCG
		}
	}
}
