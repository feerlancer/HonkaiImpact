Shader "Hidden/118"
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

			//uniforms
			uniform half2 _texelSize;
			uniform sampler2D _MainTex;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 in_TEXCOORD0 : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 vs_TEXCOORD0 : TEXCOORD0;
				float2 vs_TEXCOORD1 : TEXCOORD1;
				float2 vs_TEXCOORD2 : TEXCOORD2;
				float2 vs_TEXCOORD3 : TEXCOORD3;
				
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vs_TEXCOORD0 = v.in_TEXCOORD0;

				o.vs_TEXCOORD0 = v.in_TEXCOORD0.xy + _texelSize.xy * float2(1.0, 1.0);
				o.vs_TEXCOORD1 = v.in_TEXCOORD0.xy + _texelSize.xy * float2(1.0, -1.0);
				o.vs_TEXCOORD2 = v.in_TEXCOORD0.xy + _texelSize.xy * float2(-1.0, -1.0);
				o.vs_TEXCOORD3 = v.in_TEXCOORD0.xy + _texelSize.xy * float2(-1.0, 1.0);
				return o;
			}
			

			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;
				SV_Target0 = 0.0;
				SV_Target0 += tex2D(_MainTex, i.vs_TEXCOORD0.xy);
				SV_Target0 += tex2D(_MainTex, i.vs_TEXCOORD1.xy);
				SV_Target0 += tex2D(_MainTex, i.vs_TEXCOORD2.xy);
				SV_Target0 += tex2D(_MainTex, i.vs_TEXCOORD3.xy);
				SV_Target0 *= 0.25;
				return SV_Target0;
			}
			ENDCG
		}
	}
}
