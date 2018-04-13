Shader "HonKai/GirlEye"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		//_MainTex_ST("MainTex_ST",Vector) =(0.3,0.3,0.3,0)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha 
		Offset -2, -2
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			//uniform 	float4 _ProjectionParams;
			//uniform 	float4x4 glstate_matrix_mvp;
			uniform half4 _MainTex_ST ;
			const static half3 _ColorToOffset=half3(0,0,0);
			const static float _UsingDitherAlpha=0;
			const static float _DitherAlpha=1;

			//const static float4 _ScreenParams;
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
				half3 u_xlat16_1;
				fixed2 u_xlat10_2;
				half3 u_xlat16_3;
				float4 u_xlat4;
				int3 u_xlati4;
				half u_xlat16_6;
				fixed u_xlat10_7;
				int u_xlati10;
				bool u_xlatb10;
				half2 u_xlat16_11;
				fixed u_xlat10_12;

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

				//u_xlat0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				//u_xlat0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
				//u_xlat0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
				//u_xlat0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
				//gl_Position = u_xlat0;
				u_xlat0 = UnityObjectToClipPos(in_POSITION0);
				vertex = u_xlat0;

				vs_COLOR0 = float4(0.0, 0.0, 0.0, 0.0);
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				//vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
				vs_TEXCOORD0.y = 1 - vs_TEXCOORD0.y;

				u_xlat16_1.x = (-_ColorToOffset.x) + _ColorToOffset.y;
				u_xlat16_1.x = u_xlat16_1.x + 1.0;
				u_xlat16_1.x = floor(u_xlat16_1.x);
				u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
				u_xlati10 = int(u_xlat16_1.x);
				u_xlat10_2.xy = (int(u_xlati10) != 0) ? _ColorToOffset.xy : _ColorToOffset.yx;
				u_xlat16_1.x = (-u_xlat10_2.x) + _ColorToOffset.z;
				u_xlat16_1.x = u_xlat16_1.x + 1.0;
				u_xlat16_1.x = floor(u_xlat16_1.x);
				u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
				u_xlati10 = int(u_xlat16_1.x);
				u_xlat10_2.x = (u_xlati10 != 0) ? u_xlat10_2.x : _ColorToOffset.z;
				u_xlat16_1.x = u_xlat10_2.y + (-_ColorToOffset.z);
				u_xlat16_1.x = u_xlat16_1.x + 1.0;
				u_xlat16_1.x = floor(u_xlat16_1.x);
				u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
				u_xlati10 = int(u_xlat16_1.x);
				u_xlat10_7 = (u_xlati10 != 0) ? u_xlat10_2.y : _ColorToOffset.z;
				u_xlat10_2.x = (-u_xlat10_2.x) + u_xlat10_7;
				u_xlat16_1.xyz = float3(u_xlat10_7, u_xlat10_7, u_xlat10_7)+(-_ColorToOffset.yzx);
				u_xlat16_1.xyz = float3(3.0, 3.0, 3.0) * u_xlat10_2.xxx + u_xlat16_1.xyz;
				u_xlat10_12 = u_xlat10_2.x * 6.0;
				u_xlat16_1.xyz = u_xlat16_1.xyz / float3(u_xlat10_12, u_xlat10_12, u_xlat10_12);
				u_xlat16_3.xy = u_xlat16_1.zx + float2(0.333333343, 0.666666687);
				u_xlat16_11.xy = float2((-u_xlat16_1.y) + u_xlat16_3.x, (-u_xlat16_1.z) + u_xlat16_3.y);
				u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
				u_xlat16_3.xyz = (-float3(u_xlat10_7, u_xlat10_7, u_xlat10_7)) + _ColorToOffset.xyz;
				u_xlat16_3.xyz = abs(u_xlat16_3.xyz) + float3(0.999000013, 0.999000013, 0.999000013);
				u_xlat16_3.xyz = floor(u_xlat16_3.xyz);
				u_xlati4.xyz = int3(u_xlat16_3.xyz);
				u_xlat16_6 = (u_xlati4.z != 0) ? 0.0 : u_xlat16_11.y;
				u_xlat16_6 = (u_xlati4.y != 0) ? u_xlat16_6 : u_xlat16_11.x;
				u_xlat16_1.x = (u_xlati4.x != 0) ? u_xlat16_6 : u_xlat16_1.x;
				u_xlat16_1.y = u_xlat10_2.x / u_xlat10_7;
				vs_TEXCOORD1.z = u_xlat10_7;
				u_xlat10_2.x = abs(u_xlat10_2.x) + 0.999000013;
				u_xlat10_2.x = floor(u_xlat10_2.x);
				u_xlati10 = int(u_xlat10_2.x);
				vs_TEXCOORD1.xy = (int(u_xlati10) != 0) ? u_xlat16_1.xy : float2(0.0, 0.0);
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				u_xlat4.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat4.zz + u_xlat4.xw;
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

				float3 u_xlat0;
				fixed4 u_xlat10_0;
				int3 u_xlati0;
				uint2 u_xlatu0;
				bool u_xlatb0;
				float4 u_xlat1;
				half4 u_xlat16_1;
				int u_xlati1;
				half4 u_xlat16_2;
				fixed4 u_xlat10_3;
				int4 u_xlati3;
				half4 u_xlat16_4;
				half3 u_xlat16_5;
				bool u_xlatb6;
				fixed u_xlat10_10;
				bool2 u_xlatb14;
				half u_xlat16_16;
				fixed u_xlat10_17;
				half u_xlat16_23;

				half2 vs_TEXCOORD0 = i.vs_TEXCOORD0;
				half3 vs_TEXCOORD1 = i.vs_TEXCOORD1;
				float4 vs_TEXCOORD2 = i.vs_TEXCOORD2;

				float4 ImmCB_0_0_0[4];
				ImmCB_0_0_0[0] = float4(1.0, 0.0, 0.0, 0.0);
				ImmCB_0_0_0[1] = float4(0.0, 1.0, 0.0, 0.0);
				ImmCB_0_0_0[2] = float4(0.0, 0.0, 1.0, 0.0);
				ImmCB_0_0_0[3] = float4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha_UsingDitherAlpha));
#else
				u_xlatb0 = float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha);
#endif
				if (u_xlatb0) {
#ifdef UNITY_ADRENO_ES3
					u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
					u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
					if (u_xlatb0) {
						u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
						u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
						u_xlat0.xy = u_xlat0.xy * float2(0.25, 0.25);
						u_xlatb14.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
						u_xlat0.xy = frac(abs(u_xlat0.xy));
						u_xlat0.x = (u_xlatb14.x) ? u_xlat0.x : (-u_xlat0.x);
						u_xlat0.y = (u_xlatb14.y) ? u_xlat0.y : (-u_xlat0.y);
						u_xlat0.xy = u_xlat0.xy * float2(4.0, 4.0);
						u_xlatu0.xy = uint2(u_xlat0.xy);
						u_xlat1.x = dot(_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.y = dot(_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.z = dot(_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.w = dot(_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
						u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
						u_xlat0.x = u_xlat0.x + 0.99000001;
						u_xlat0.x = floor(u_xlat0.x);
						u_xlat0.x = max(u_xlat0.x, 0.0);
						u_xlati0.x = int(u_xlat0.x);
						if ((u_xlati0.x) == 0) { discard; }
						//ENDIF
					}
					//ENDIF
				}
				u_xlat10_0 = tex2D(_MainTex, vs_TEXCOORD0.xy);
				u_xlat16_2.x = (-u_xlat10_0.x) + u_xlat10_0.y;
				u_xlat16_2.x = u_xlat16_2.x + 1.0;
				u_xlat16_2.x = floor(u_xlat16_2.x);
				u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
				u_xlati1 = int(u_xlat16_2.x);
				u_xlat10_3.xy = (int(u_xlati1) != 0) ? u_xlat10_0.xy : u_xlat10_0.yx;
				u_xlat16_2.x = (-u_xlat10_0.z) + u_xlat10_3.y;
				u_xlat16_2.x = u_xlat16_2.x + 1.0;
				u_xlat16_2.x = floor(u_xlat16_2.x);
				u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
				u_xlati1 = int(u_xlat16_2.x);
				u_xlat10_10 = (u_xlati1 != 0) ? u_xlat10_3.y : u_xlat10_0.z;
				u_xlat16_2.x = u_xlat10_0.z + (-u_xlat10_3.x);
				u_xlat16_2.x = u_xlat16_2.x + 1.0;
				u_xlat16_2.x = floor(u_xlat16_2.x);
				u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
				u_xlati1 = int(u_xlat16_2.x);
				u_xlat10_3.x = (u_xlati1 != 0) ? u_xlat10_3.x : u_xlat10_0.z;
				u_xlat10_3.x = (-u_xlat10_3.x) + u_xlat10_10;
				u_xlat10_17 = abs(u_xlat10_3.x) + 0.999000013;
				u_xlat10_17 = floor(u_xlat10_17);
				u_xlati1 = int(u_xlat10_17);
				u_xlat16_2.y = u_xlat10_3.x / u_xlat10_10;
				u_xlat16_4.xyz = (-u_xlat10_0.yzx) + float3(u_xlat10_10, u_xlat10_10, u_xlat10_10);
				u_xlat10_17 = u_xlat10_3.x * 6.0;
				u_xlat16_4.xyz = float3(3.0, 3.0, 3.0) * u_xlat10_3.xxx + u_xlat16_4.xyz;
				u_xlat16_4.xyz = u_xlat16_4.xyz / float3(u_xlat10_17, u_xlat10_17, u_xlat10_17);
				u_xlat16_5.xyz = u_xlat10_0.xyz + (-float3(u_xlat10_10, u_xlat10_10, u_xlat10_10));
				u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + float3(0.999000013, 0.999000013, 0.999000013);
				u_xlat16_5.xyz = floor(u_xlat16_5.xyz);
				u_xlat16_16 = (-u_xlat16_4.x) + u_xlat16_4.y;
				u_xlat16_4.xw = u_xlat16_4.zx + float2(0.333333343, 0.666666687);
				u_xlati0.xyz = int3(u_xlat16_5.xyz);
				u_xlat16_4.xy = float2((-u_xlat16_4.y) + u_xlat16_4.x, (-u_xlat16_4.z) + u_xlat16_4.w);
				u_xlat16_23 = (u_xlati0.z != 0) ? 0.0 : u_xlat16_4.y;
				u_xlat16_23 = (u_xlati0.y != 0) ? u_xlat16_23 : u_xlat16_4.x;
				u_xlat16_2.x = (u_xlati0.x != 0) ? u_xlat16_23 : u_xlat16_16;
				u_xlat16_2.xy = (int(u_xlati1) != 0) ? u_xlat16_2.xy : float2(0.0, 0.0);
				u_xlat16_4.xy = u_xlat16_2.xy + (-vs_TEXCOORD1.xy);
				u_xlat16_4.z = u_xlat10_10 + (-vs_TEXCOORD1.z);
				u_xlat16_16 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
				u_xlat16_16 = sqrt(u_xlat16_16);
				u_xlat16_4.xy = u_xlat16_2.xy + float2(_HueOffset, _SaturateOffset);
				u_xlat16_4.x = frac(u_xlat16_4.x);
				u_xlat16_4.y = u_xlat16_4.y;
#ifdef UNITY_ADRENO_ES3
				u_xlat16_4.y = min(max(u_xlat16_4.y, 0.0), 1.0);
#else
				u_xlat16_4.y = clamp(u_xlat16_4.y, 0.0, 1.0);
#endif
				u_xlat16_4.z = u_xlat10_10 + _ValueOffset;
#ifdef UNITY_ADRENO_ES3
				u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
#else
				u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
#endif
				u_xlat16_16 = u_xlat16_16 + (-_ColorTolerance);
#ifdef UNITY_ADRENO_ES3
				u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
				u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
				u_xlat16_16 = ceil(u_xlat16_16);
				u_xlat16_5.xy = u_xlat16_2.xy + (-u_xlat16_4.xy);
				u_xlat16_5.z = u_xlat10_10 + (-u_xlat16_4.z);
				u_xlat16_2.xyz = float3(u_xlat16_16, u_xlat16_16, u_xlat16_16)* u_xlat16_5.xyz + u_xlat16_4.xyz;
				u_xlat16_23 = u_xlat16_2.x * 6.0;
				u_xlat10_3.x = floor(u_xlat16_23);
				u_xlat16_2.w = (-u_xlat16_2.y) + 1.0;
				u_xlat10_10 = u_xlat16_2.x * 6.0 + (-u_xlat10_3.x);
				u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat10_10 + 1.0;
				u_xlat16_1.yz = u_xlat16_2.wx * u_xlat16_2.zz;
				u_xlat10_10 = (-u_xlat10_10) + 1.0;
				u_xlat16_2.x = (-u_xlat16_2.y) * u_xlat10_10 + 1.0;
				u_xlat16_1.x = u_xlat16_2.x * u_xlat16_2.z;
				u_xlat10_10 = abs(u_xlat10_3.x) + 0.999000013;
				u_xlat10_10 = floor(u_xlat10_10);
				u_xlati0.x = int(u_xlat10_10);
				u_xlat10_3 = u_xlat10_3.xxxx + float4(-1.0, -2.0, -3.0, -4.0);
				u_xlat10_3 = abs(u_xlat10_3) + float4(0.999000013, 0.999000013, 0.999000013, 0.999000013);
				u_xlat10_3 = floor(u_xlat10_3);
				u_xlati3 = int4(u_xlat10_3);
				u_xlat16_1.w = u_xlat16_2.z;
				u_xlat16_2.xyz = (u_xlati3.w != 0) ? u_xlat16_1.wyz : u_xlat16_1.xyw;
				u_xlat16_2.xyz = (u_xlati3.z != 0) ? u_xlat16_2.xyz : u_xlat16_1.yzw;
				u_xlat16_2.xyz = (u_xlati3.y != 0) ? u_xlat16_2.xyz : u_xlat16_1.ywx;
				u_xlat16_2.xyz = (u_xlati3.x != 0) ? u_xlat16_2.xyz : u_xlat16_1.zwy;
				u_xlat16_2.xyz = (u_xlati0.x != 0) ? u_xlat16_2.xyz : u_xlat16_1.wxy;
				u_xlat0.xyz = u_xlat16_2.xyz * _Color.xyz;
				u_xlat0.xyz = u_xlat0.xyz * float3(float3(_EmissionFactor, _EmissionFactor, _EmissionFactor));
#ifdef UNITY_ADRENO_ES3
				u_xlatb6 = !!(0.5<_lightProbToggle);
#else
				u_xlatb6 = 0.5<_lightProbToggle;
#endif
				u_xlat16_2.xyz = (bool(u_xlatb6)) ? _lightProbColor.xyz : float3(1.0, 1.0, 1.0);
				u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
				SV_Target0.xyz = u_xlat16_2.xyz;
				SV_Target0.w = u_xlat10_0.w;
			//	float4 vertex : SV_POSITION;
			//float4 vs_COLOR0 : COLOR0;
			//half2 vs_TEXCOORD0 : TEXCOORD0;
			//half3 vs_TEXCOORD1 : TEXCOORD1;
			//float4 vs_TEXCOORD2 : TEXCOORD2;
				//SV_Target0 = half4(i.vs_TEXCOORD1, 1);
				return SV_Target0;
			}
			ENDCG
		}
	}
}
