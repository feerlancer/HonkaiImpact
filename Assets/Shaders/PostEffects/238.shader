Shader "Hidden/238"
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

			uniform half4 coeff;
			uniform sampler2D _MainTex0;
			uniform sampler2D _MainTex1;
			uniform sampler2D _MainTex2;
			uniform sampler2D _MainTex3;

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vs_TEXCOORD0 = v.uv;
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				//blend 4 textures
				half4 SV_Target0;
				SV_Target0 = 0.0;
				SV_Target0 += coeff.x * tex2D(_MainTex0, i.vs_TEXCOORD0.xy);
				SV_Target0 += coeff.y * tex2D(_MainTex1, i.vs_TEXCOORD0.xy);
				SV_Target0 += coeff.z * tex2D(_MainTex2, i.vs_TEXCOORD0.xy);
				SV_Target0 += coeff.w * tex2D(_MainTex3, i.vs_TEXCOORD0.xy);
				return SV_Target0;
			}
			ENDCG
		}
	}
}
