Shader "HonKai/GirlEyeSurf"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque"}
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha 
		Offset -2, -2
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			uniform half4 _MainTex_ST ;
			const static half3 _ColorToOffset=half3(0,0,0);
			const static float _UsingDitherAlpha=0;
			const static float _DitherAlpha=1;

			const static fixed _lightProbToggle=0;
			const static half4 _lightProbColor = half4(0,0,0,0);
			const static float4x4 _DITHERMATRIX=
			{
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				0,0,0,1
			};
			const static float4 _Color = half4(0.9313725, 0.9313725, 0.9313725, 0.95);
			const static half _EmissionFactor=1;
			const static half _ColorTolerance=0;
			const static half _HueOffset=0;
			const static half _SaturateOffset=0;
			const static half _ValueOffset=0;


			uniform sampler2D _MainTex;

			struct appdata
			{
				float4 in_POSITION0 : POSITION;
				half2 in_TEXCOORD0 : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 vs_COLOR0 : COLOR0;
				half2 vs_TEXCOORD0 : TEXCOORD0;
				half3 vs_TEXCOORD1 : TEXCOORD1;
				float4 vs_TEXCOORD2 : TEXCOORD2;
			};

			bool4 notEqual(float4 a, float4 b)
			{
				return bool4(a.x != b.x, a.y != b.y, a.z != b.z, a.w != b.w);
			}
			bool4 greaterThanEqual(float4 a, float4 b)
			{
				return bool4(a.x >= b.x, a.y >= b.y, a.z >= b.z, a.w >= b.w);
			}

			v2f vert (appdata v)
			{
				float4 u_xlat0;
				half u_xlat16_6;
				bool u_xlatb10;
				half2 u_xlat16_11;
				//in
				float4 in_POSITION0 = v.in_POSITION0;
				half2 in_TEXCOORD0 = v.in_TEXCOORD0;
				//out
				float4 vertex;
				float4 vs_COLOR0;
				half2 vs_TEXCOORD0;
				half3 vs_TEXCOORD1;
				float4 vs_TEXCOORD2;

				v2f o;

				float4 clipPos = UnityObjectToClipPos(in_POSITION0);
				vertex = clipPos;

				vs_COLOR0 = float4(0.0, 0.0, 0.0, 0.0);
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.y = 1 - vs_TEXCOORD0.y;

				fixed2 orderedXY = (_ColorToOffset.y > _ColorToOffset.x) ? _ColorToOffset.xy : _ColorToOffset.yx;
				fixed XYZMin = min(orderedXY.x, _ColorToOffset.z);
				fixed XYZMax = max(orderedXY.y , _ColorToOffset.z);
				fixed XYRange = XYZMax - XYZMin;

				half3 ColorToOffsetRation = (XYZMax - _ColorToOffset.yzx + 3 * XYRange) / (XYRange * 6.0);

				u_xlat16_11.x = ColorToOffsetRation.z + 0.333333343 - ColorToOffsetRation.y;
				u_xlat16_11.y = ColorToOffsetRation.x + 0.666666687 - ColorToOffsetRation.z;

				ColorToOffsetRation.x = (-ColorToOffsetRation.x) + ColorToOffsetRation.y;
				u_xlat16_6 = _ColorToOffset.z != XYZMax ? 0.0 : u_xlat16_11.y;
				u_xlat16_6 = _ColorToOffset.y != XYZMax ? u_xlat16_6 : u_xlat16_11.x;
				ColorToOffsetRation.x = _ColorToOffset.x != XYZMax? u_xlat16_6 : ColorToOffsetRation.x;

				ColorToOffsetRation.y = XYRange / XYZMax;
				vs_TEXCOORD1.z = XYZMax;

				vs_TEXCOORD1.xy = XYRange!=0? ColorToOffsetRation.xy : float2(0.0, 0.0);

				clipPos.y = clipPos.y * _ProjectionParams.x;
				u_xlat0.xy = 0.5* clipPos.ww + clipPos.xy*0.5;

#ifdef UNITY_ADRENO_ES3
				u_xlatb10 = !!(float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha));
#else
				u_xlatb10 = float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha);
#endif
				vs_TEXCOORD2.xy = lerp(float2(0.0, 0.0), u_xlat0.xy, float2(bool2(u_xlatb10, u_xlatb10)));
				vs_TEXCOORD2.w = u_xlatb10 ? u_xlat0.w : float(0.0);
				vs_TEXCOORD2.z = u_xlatb10 ? _DitherAlpha : float(0.0);


				o.vertex = vertex;
				o.vs_COLOR0 = vs_COLOR0;
				o.vs_TEXCOORD0 = vs_TEXCOORD0;
				o.vs_TEXCOORD1 = vs_TEXCOORD1;
				o.vs_TEXCOORD2 = vs_TEXCOORD2;
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float4 SV_Target0;
				half4 u_xlat16_1;
				half4 u_xlat16_4;
				half3 u_xlat16_5;
				half u_xlat16_23;

				half2 vs_TEXCOORD0 = i.vs_TEXCOORD0;
				half3 vs_TEXCOORD1 = i.vs_TEXCOORD1;
				float4 vs_TEXCOORD2 = i.vs_TEXCOORD2;

				if(_UsingDitherAlpha){
					//TODO
				}
				fixed4 mainColor = tex2D(_MainTex, vs_TEXCOORD0.xy);

				float mainColor_Y_minus_X = (-mainColor.x) + mainColor.y;
				fixed2 orderedXY = mainColor_Y_minus_X >= 0.0f ? mainColor.xy : mainColor.yx;

				float Y_minus_Z = (-mainColor.z) + orderedXY.y;
				fixed XYZMax = Y_minus_Z >= 0.0f ? orderedXY.y : mainColor.z;

				float Z_minus_X = mainColor.z- orderedXY.x;
				fixed XYZMin = Z_minus_X >= 0.0f ? orderedXY.x : mainColor.z;
				fixed XYZRange = (-XYZMin) + XYZMax;

				half4  MainColorFactor;
				MainColorFactor.y = XYZRange / XYZMax;

				half4 MainYZXRation;
				MainYZXRation.xyz= (XYZMax - mainColor.yzx) / (XYZRange * 6.0) + 0.5;

				half MainYZXRationRange = -MainYZXRation.x + MainYZXRation.y;
				MainYZXRation.xw = MainYZXRation.zx + float2(0.333333343, 0.666666687);

				MainYZXRation.xy = float2((-MainYZXRation.y) + MainYZXRation.x, (-MainYZXRation.z) + MainYZXRation.w);

				u_xlat16_23 = (mainColor.z!=XYZMax) ? 0.0 : MainYZXRation.y;
				u_xlat16_23 = (mainColor.y!= XYZMax) ? u_xlat16_23 : MainYZXRation.x;
				MainColorFactor.x = (mainColor.x != XYZMax) ? u_xlat16_23 : MainYZXRationRange;

				MainColorFactor.xy = XYZRange!= 0.0 ? MainColorFactor.xy : float2(0.0, 0.0);

				u_xlat16_4.xy = MainColorFactor.xy + (-vs_TEXCOORD1.xy);
				u_xlat16_4.z = XYZMax + (-vs_TEXCOORD1.z);

				half colorOffsetLength = length(u_xlat16_4.xyz);

				half4 MainColorFactorTint;
				MainColorFactorTint.xy = MainColorFactor.xy + float2(_HueOffset, _SaturateOffset);
				MainColorFactorTint.x = frac(MainColorFactorTint.x);

				MainColorFactorTint.y = saturate(MainColorFactorTint.y);
				MainColorFactorTint.z = saturate(XYZMax + _ValueOffset);

				colorOffsetLength = saturate(colorOffsetLength -_ColorTolerance);
				colorOffsetLength = ceil(colorOffsetLength);

				u_xlat16_5.xy = MainColorFactor.xy - MainColorFactorTint.xy;
				u_xlat16_5.z = XYZMax-MainColorFactorTint.z;
				half4 finalColorTune;
				finalColorTune.xyz = colorOffsetLength* u_xlat16_5.xyz + MainColorFactorTint.xyz;

				fixed Tune_X_6_Floor = floor(finalColorTune.x * 6.0);

				finalColorTune.w = (-finalColorTune.y) + 1.0;

				fixed Tune_X_6_Frac = frac(finalColorTune.x * 6.0);

				finalColorTune.x = (-finalColorTune.y) * Tune_X_6_Frac + 1.0;
				u_xlat16_1.yz = finalColorTune.wx * finalColorTune.zz;

				finalColorTune.x = (-finalColorTune.y) * (1.0 - Tune_X_6_Frac) + 1.0;
				u_xlat16_1.x = finalColorTune.x * finalColorTune.z;

				u_xlat16_1.w = finalColorTune.z;

				finalColorTune.xyz = (Tune_X_6_Floor != 4.0) ? u_xlat16_1.wyz : u_xlat16_1.xyw;
				finalColorTune.xyz = (Tune_X_6_Floor != 3.0) ? finalColorTune.xyz : u_xlat16_1.yzw;
				finalColorTune.xyz = (Tune_X_6_Floor != 2.0) ? finalColorTune.xyz : u_xlat16_1.ywx;
				finalColorTune.xyz = (Tune_X_6_Floor != 1.0) ? finalColorTune.xyz : u_xlat16_1.zwy;
				finalColorTune.xyz = (Tune_X_6_Floor!=0) ? finalColorTune.xyz : u_xlat16_1.wxy;

				float3 TunedColor;
				TunedColor.xyz = finalColorTune.xyz * _Color.xyz;
				TunedColor.xyz *= _EmissionFactor;

				float3 lightProbColor = (0.5<_lightProbToggle) ? _lightProbColor.xyz : float3(1.0, 1.0, 1.0);
				SV_Target0.xyz = TunedColor.xyz * lightProbColor.xyz;
				SV_Target0.w = mainColor.w;

				return SV_Target0;
			}
			ENDCG
		}
	}
}
