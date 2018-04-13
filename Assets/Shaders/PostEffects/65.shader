Shader "Hidden/65"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 vs_TEXCOORD0 : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			uniform half2 _scaler;
			uniform sampler2D _MainTex;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vs_TEXCOORD0 = v.uv;
				return o;
			}
			
			static const int sampleNum = 5;
			static const float offsets[sampleNum] = {
				-0.0119120004
				,-0.00476399995
				,0.00154700002
				,0.00823399983
				,0.015625
			};
			static const float weights[sampleNum] = {
				0.00860899966
				,0.308025986
				,0.607088029
				,0.0758519992
				,0.000425000006
			};
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;

				float2 vs_TEXCOORD0 = i.vs_TEXCOORD0;

				SV_Target0 = 0.0;
				for (int i = 0; i < sampleNum; ++i)
				{
					float2 uv = _scaler.xy * offsets[i] + vs_TEXCOORD0.xy;
					SV_Target0 += weights[i] * tex2D(_MainTex, uv);
				}

				return SV_Target0;
			}
			ENDCG
		}
	}
}
