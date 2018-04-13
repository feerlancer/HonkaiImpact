Shader "Hidden/68"
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
			static const int sampleNum = 19;
			static const float offsets[sampleNum] = {
				-0.539946973
				,-0.478147
				,-0.416377991
				,-0.354636997
				,-0.29292199
				,-0.231227994
				,-0.169552997
				,-0.107891001
				,-0.0462369993
				,0.015412
				,0.0770630017
				,0.138720006
				,0.200387999
				,0.262071997
				,0.323776007
				,0.385504007
				,0.447257996
				,0.509042978
				,0.5625
			};
			static const float weights[sampleNum] = {
				4.89999984e-05
				,0.000291000004
				,0.00138300005
				,0.00529999984
				,0.0163780004
				,0.0408219993
				,0.0820680037
				,0.133082002
				,0.174079999
				,0.183685005
				,0.156350002
				,0.107352003
				,0.0594570003
				,0.0265619997
				,0.009571
				,0.00278099999
				,0.000652000017
				,0.000123000005
				,1.40000002e-05
			};
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;

				float2 vs_TEXCOORD0 = i.vs_TEXCOORD0;;

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
