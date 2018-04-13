Shader "Hidden/67"
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
			
			static const int sampleNum = 11 ;
			static const float offsets[sampleNum] = 
			{
				-0.143375993	
				,-0.112940997	
				,-0.0826620013	
				,-0.0525240004	
				,-0.0224900004	
				,0.00749500003	
				,0.037498001	
				,0.0675780028
				,0.0977829993
				,0.128139004
				,0.15625
			};
			static const float weights[sampleNum] = 
			{
				0.000270999997	
				,0.00389300007	
				,0.0297420006	
				,0.121250004	
				,0.264445007	
				,0.309049994	
				,0.193601996
				,0.0649449974
				,0.0116410004
				,0.00111199997
				,4.80000017e-05
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
