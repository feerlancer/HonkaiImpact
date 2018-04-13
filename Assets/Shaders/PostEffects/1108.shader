// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

Shader "Hidden/1108"
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
//#			define NO_FXAA
//#			define NO_BLOOM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 in_POSITION0 : POSITION;
				float2 in_TEXCOORD0 : TEXCOORD0;
			};

			struct v2f
			{
				float2 vs_TEXCOORD0 : TEXCOORD0;
				float4 vs_TEXCOORD1 : TEXCOORD1;
				float4 vs_TEXCOORD2 : TEXCOORD2;
				float4 vs_TEXCOORD3 : TEXCOORD3;
				float4 vertex : SV_POSITION;
			};

			uniform 	float4 _MainTex_TexelSize;
			uniform 	half4 ttunity_ColorSpaceLuminance;
			uniform 	half3 coeff;
			uniform 	float exposure;
			uniform 	float constrast;
			uniform 	half _EdgeThresholdMin;
			uniform 	half _EdgeThreshold;
			uniform 	half _EdgeSharpness;
			uniform sampler2D _DistortionTex;
			uniform sampler2D _MainTex0;
			uniform sampler2D _MainTex1;

			bool4 equal(float4 a, float4 b)
			{
				return bool4(a.x == b.x, a.y == b.y, a.z == b.z, a.w == b.w);
			}

			v2f vert (appdata v)
			{
				//in
				float4 in_POSITION0 = v.in_POSITION0;
				//TODO
				half2 in_TEXCOORD0 = v.in_TEXCOORD0;
				//out
				float2 vs_TEXCOORD0;
				float4 vs_TEXCOORD1;
				float4 vs_TEXCOORD2;
				float4 vs_TEXCOORD3;

				v2f o;
				o.vertex = UnityObjectToClipPos(v.in_POSITION0);

				vs_TEXCOORD0.xy = in_TEXCOORD0.xy;

				vs_TEXCOORD1.xy = (-_MainTex_TexelSize.xy) * float2(0.5, 0.5) + in_TEXCOORD0.xy;
				vs_TEXCOORD1.zw = _MainTex_TexelSize.xy * float2(0.5, 0.5) + in_TEXCOORD0.xy;
				vs_TEXCOORD2 = _MainTex_TexelSize.xyxy * float4(-0.5, -0.5, 0.5, 0.5);
				vs_TEXCOORD3.xy = _MainTex_TexelSize.xy * (-2.0);
				vs_TEXCOORD3.zw = _MainTex_TexelSize.xy * 2.0;

				o.vs_TEXCOORD0 = vs_TEXCOORD0;
				o.vs_TEXCOORD1 = vs_TEXCOORD1;
				o.vs_TEXCOORD2 = vs_TEXCOORD2;
				o.vs_TEXCOORD3 = vs_TEXCOORD3;
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;

				float2 vs_TEXCOORD0 = i.vs_TEXCOORD0;
				float4 vs_TEXCOORD1 = i.vs_TEXCOORD1;
				float4 vs_TEXCOORD2 = i.vs_TEXCOORD2;
				float4 vs_TEXCOORD3 = i.vs_TEXCOORD3;

				fixed2 DistortionColor = tex2D(_DistortionTex, vs_TEXCOORD0.xy).xy;
				//DistortionColor is 127/255 here, so actually UV results to vs_TEXCOORD0
				//float2 UV = (DistortionColor - 0.497999996) * 0.200000003 + vs_TEXCOORD0.xy;
				float2 UV = vs_TEXCOORD0.xy;

//------------------------------------------FXAA 3.11 Begin----------------------------------------------------------------------------------------------------
				fixed4 offsetMainColor = tex2D(_MainTex0, UV);
				half4 finalMainColor;
#ifndef NO_FXAA
				fixed3 WSColor = tex2D(_MainTex0, vs_TEXCOORD1.xy).xyz;
				half WSLuma = dot(WSColor.xyz, ttunity_ColorSpaceLuminance.xyz);
				fixed3 WNColor = tex2D(_MainTex0, vs_TEXCOORD1.xw).xyz;
				half WNLuma = dot(WNColor.xyz, ttunity_ColorSpaceLuminance.xyz);
				fixed3 ESColor = tex2D(_MainTex0, vs_TEXCOORD1.zy).xyz;
				half ESLuma = dot(ESColor.xyz, ttunity_ColorSpaceLuminance.xyz);
				fixed3 ENColor = tex2D(_MainTex0, vs_TEXCOORD1.zw).xyz;
				half ENLuma = dot(ENColor.xyz, ttunity_ColorSpaceLuminance.xyz);
				//fixed4 offsetMainColor = tex2D(_MainTex0, UV);
				half mainLuma = dot(offsetMainColor.xyz, ttunity_ColorSpaceLuminance.xyz);

				//ESLuma += 0.00260416674;
				ESLuma += 1.0/384.0;
				half maxLuma = max(max(WNLuma, WSLuma), max(ENLuma, ESLuma));
				half minLuma = min(min(WNLuma, WSLuma), min(ENLuma, ESLuma));
				minLuma = min(mainLuma, minLuma);
				maxLuma = max(mainLuma, maxLuma);

				half lumaRange = maxLuma - minLuma;


				
				if (lumaRange > max(maxLuma * _EdgeThreshold, _EdgeThresholdMin)) 
				{
					half2 Vert_Hori_Contrast = normalize(half2(ENLuma + WNLuma - WSLuma - ESLuma, WSLuma + WNLuma - ENLuma - ESLuma));

					float2 finalOffsetUV1 = (-Vert_Hori_Contrast) * vs_TEXCOORD2.zw + UV.xy;
					fixed3 finalOffsetColor1 = tex2D(_MainTex0, finalOffsetUV1).xyz;
					float2 mirror_finalOffsetUV1 = Vert_Hori_Contrast * vs_TEXCOORD2.zw + UV.xy;
					fixed3 mirror_finalOffsetColor1 = tex2D(_MainTex0, mirror_finalOffsetUV1).xyz;

					half minAbsLumaCrossDiff = _EdgeSharpness * min(abs(Vert_Hori_Contrast.y), abs(Vert_Hori_Contrast.x));
					Vert_Hori_Contrast.xy = clamp(Vert_Hori_Contrast.xy / minAbsLumaCrossDiff, -2.0, 2.0);
					float2 finalOffsetUV2 = (-Vert_Hori_Contrast.xy) * vs_TEXCOORD3.zw + UV.xy;
					fixed3 finalOffsetColor2 = tex2D(_MainTex0, finalOffsetUV2).xyz;
					float2 mirror_finalOffsetUV2 = Vert_Hori_Contrast.xy * vs_TEXCOORD3.zw + UV.xy;
					fixed3 mirror_finalOffsetColor2 = tex2D(_MainTex0, mirror_finalOffsetUV2).xyz;

					half3 Color1 = finalOffsetColor1.xyz + mirror_finalOffsetColor1.xyz;
					half3 offsetColor2 = finalOffsetColor2.xyz + mirror_finalOffsetColor2.xyz;
					half3 Color12 = offsetColor2 * 0.25 + Color1 * 0.25;
					half Color1Luma = dot(Color1, ttunity_ColorSpaceLuminance.xyz);
					half Color12Luma = dot(Color12, ttunity_ColorSpaceLuminance.xyz);
					Color1 = Color1 * 0.5;
					finalMainColor.xyz = ((minLuma < Color1Luma) && (Color12Luma < maxLuma)) ? Color12 : Color1;
				}
				else 
#endif//ifndef NO_FXAA
				{

					finalMainColor.xyz = offsetMainColor.xyz;
				}

//------------------------------------------------FXAA 3.11 End----------------------------------------------------------------------------------------------------

				finalMainColor.w = offsetMainColor.w;

#ifndef NO_BLOOM
				//Bloom
				fixed4 bloomColor = tex2D(_MainTex1, UV.xy);
				float4 bloomedColor = bloomColor * coeff.y + finalMainColor *coeff.x;
#else
				float4 bloomedColor = finalMainColor;
#endif//ifndef NO_BLOOM

#ifndef NO_BLOOM
				//expose && constrast
				SV_Target0.xyz = exp2((constrast + 0.00999999978) * log2(1.0 - exp2(bloomedColor.xyz *(-exposure))));

				SV_Target0.w = bloomedColor.w;
#else
				SV_Target0 = finalMainColor;
#endif//ifndef NO_BLOOM
				return SV_Target0;
			}
			ENDCG
		}
	}
}
