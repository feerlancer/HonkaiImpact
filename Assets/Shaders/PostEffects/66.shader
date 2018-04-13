Shader "Hidden/66"
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

			static const int sampleNum = 8;
			static const float offsets[sampleNum] = {-0.0475560017	,-0.0325350016	,-0.0178779997	,-0.00355400005	,0.0106859999	,0.0251579992	,0.0400049984	,0.0546879992	};
			static const float weights[sampleNum] = {0.000394000002	,0.0159489997	,0.163608998	,0.439938992	,0.316579998	,0.0605119988	,0.00298199989	,3.40000006e-05	};
			half4 frag (v2f i) : SV_Target 
			{
				half4 SV_Target0 = 0.0;
				float2 vs_TEXCOORD0 = i.vs_TEXCOORD0;
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
