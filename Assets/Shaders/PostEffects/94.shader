Shader "Hidden/94"
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

			uniform float _Threshhold;
			uniform float _Scaler;
			uniform sampler2D _MainTex;
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
				//Extracting bright color
				half4 SV_Target0;
				float4 mainColor = tex2D(_MainTex, i.vs_TEXCOORD0.xy) ;
				float3 color = (mainColor.xyz - _Threshhold) * mainColor.w * _Scaler;
				SV_Target0 = max(half4(color, mainColor.w), 0.0);
				return SV_Target0;
			}
			ENDCG
		}
	}
}
