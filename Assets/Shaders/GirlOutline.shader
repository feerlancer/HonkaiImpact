// Upgrade NOTE: replaced 'glstate_matrix_modelview0' with 'UNITY_MATRIX_MV'
// Upgrade NOTE: replaced 'glstate_matrix_projection' with 'UNITY_MATRIX_P'

Shader "HonKai/GirlOutline"
{
	Properties
	{
		_OutlineColor("OutlineColor",Vector) = (0.7803922,0.46667,0.4392157,1) //face & chest
		_OutlineWidth("OutlineWidth",Float) = 0.05 //face
		//_OutlineWidth("OutlineWidth",Float) = 0.07 //chest 

		//_OutlineColor("OutlineColor",Vector) = (0.4078431,0.2862745,0.235941,1) // leg
		//_OutlineColor("OutlineColor",Vector) = (0.4117647,0.3112941,0.3768184,1) // hair
		//_OutlineWidth("OutlineWidth",Float) = 0.07 //leg
		//_OutlineWidth("OutlineWidth",Float) = 0.05 //hair

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Cull Front
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 in_POSITION0 : POSITION;
				float4 in_TANGENT0 : TANGENT0;
				fixed4 in_COLOR0 : COLOR0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half4 vs_COLOR0: COLOR0;
				float4 vs_TEXCOORD3 : TEXCOORD3;
			};

			uniform half _OutlineWidth;
			uniform half4 _OutlineColor;
			static const half _MaxOutlineZOffset = 1;
			static const half _Scale = 0.01;
			static const float _UsingDitherAlpha = 0;
			static const float _DitherAlpha = 1;
			const static float4x4 _DITHERMATRIX =
			{
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				0,0,0,1
			};
			static const half4 _Color = half4(0.9313725, 0.9313725, 0.9313725, 0.95);

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
				float4 u_xlat1;
				half2 u_xlat16_1;
				float4 u_xlat2;
				bool u_xlatb6;
				half u_xlat16_7;
				float u_xlat11;
				//in
				float4 in_POSITION0 = v.in_POSITION0;
				float4 in_TANGENT0 = v.in_TANGENT0;
				fixed4 in_COLOR0 = v.in_COLOR0;
				//out
				half4 vs_COLOR0;
				float4 vs_TEXCOORD3;

				v2f o;
				//u_xlat0.xy = in_TANGENT0.yy * UNITY_MATRIX_MV[1].xy;
				//u_xlat0.xy = UNITY_MATRIX_MV[0].xy * in_TANGENT0.xx + u_xlat0.xy;
				//u_xlat0.xy = UNITY_MATRIX_MV[2].xy * in_TANGENT0.zz + u_xlat0.xy;
				float4x4 UNITY_MATRIX_MV_Trans = transpose(UNITY_MATRIX_MV);
				u_xlat0.xy = in_TANGENT0.yy * UNITY_MATRIX_MV[1].xy;
				u_xlat0.xy = UNITY_MATRIX_MV_Trans[0].xy * in_TANGENT0.xx + u_xlat0.xy;
				u_xlat0.xy = UNITY_MATRIX_MV_Trans[2].xy * in_TANGENT0.zz + u_xlat0.xy;

				u_xlat0.z = 0.00999999978;
				u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
				u_xlat16_1.x = rsqrt(u_xlat16_1.x);
				u_xlat16_1.xy = u_xlat0.xy * u_xlat16_1.xx;

				u_xlat0 = mul(UNITY_MATRIX_MV, in_POSITION0);

				u_xlat0 = u_xlat0 / u_xlat0.wwww;
				u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
				u_xlat2.x = rsqrt(u_xlat2.x);
				u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx;
				u_xlat2.xyz = u_xlat2.xyz * _MaxOutlineZOffset;
				u_xlat2.xyz = u_xlat2.xyz * _Scale, _Scale, _Scale;
				u_xlat11 = in_COLOR0.z + -0.5;
				u_xlat2.xyz = u_xlat2.xyz * u_xlat11+u_xlat0.xyz;
				u_xlat0.x = (-u_xlat0.z) / unity_CameraProjection[1].y;
				u_xlat16_7 = u_xlat0.x / _Scale;
				u_xlat0.x = rsqrt(u_xlat16_7);
				u_xlat0.x = float(1.0) / u_xlat0.x;
				u_xlat16_7 = _OutlineWidth * _Scale;
				u_xlat16_7 = u_xlat16_7 * in_COLOR0.w;
				u_xlat16_7 = u_xlat0.x * u_xlat16_7;
				u_xlat0.xy = u_xlat16_1.xy * float2(u_xlat16_7, u_xlat16_7)+u_xlat2.xy;


				float4x4 UNITY_MATRIX_P_Trans = transpose(UNITY_MATRIX_P);
				u_xlat1 = u_xlat0.yyyy * UNITY_MATRIX_P_Trans[1];
				u_xlat1 = UNITY_MATRIX_P_Trans[0] * u_xlat0.xxxx + u_xlat1;
				u_xlat1 = UNITY_MATRIX_P_Trans[2] * u_xlat2.zzzz + u_xlat1;
				u_xlat0 = UNITY_MATRIX_P_Trans[3] * u_xlat0.wwww + u_xlat1;

				//gl_Position = u_xlat0;
				o.vertex = u_xlat0;
				vs_COLOR0.xyz = _OutlineColor.xyz;
				vs_COLOR0.w = 1.0;
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				u_xlat2.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
				u_xlatb6 = !!(float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha));
#else
				u_xlatb6 = float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha);
#endif
				vs_TEXCOORD3.xyw = lerp(float3(0.0, 0.0, 0.0), u_xlat0.xyw, float3(bool3(u_xlatb6, u_xlatb6, u_xlatb6)));
				vs_TEXCOORD3.z = u_xlatb6 ? _DitherAlpha : float(0.0);

				o.vs_COLOR0 = vs_COLOR0;
				o.vs_TEXCOORD3 = vs_TEXCOORD3;
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;
				float2 u_xlat0;
				int u_xlati0;
				uint2 u_xlatu0;
				bool u_xlatb0;
				float4 u_xlat1;
				bool2 u_xlatb4;
				//in
				half4 vs_COLOR0 = i.vs_COLOR0;
				float4 vs_TEXCOORD3 = i.vs_TEXCOORD3;

				float4x4 ImmCB_0_0_0;
				ImmCB_0_0_0[0] = float4(1.0, 0.0, 0.0, 0.0);
				ImmCB_0_0_0[1] = float4(0.0, 1.0, 0.0, 0.0);
				ImmCB_0_0_0[2] = float4(0.0, 0.0, 1.0, 0.0);
				ImmCB_0_0_0[3] = float4(0.0, 0.0, 0.0, 1.0);
				u_xlat0.x = vs_COLOR0.w + 0.99000001;
				u_xlat0.x = floor(u_xlat0.x);
				u_xlat0.x = max(u_xlat0.x, 0.0);
				u_xlati0 = int(u_xlat0.x);
				if ((u_xlati0) == 0) { discard; }
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha));
#else
				u_xlatb0 = float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha);
#endif
				if (u_xlatb0) {
#ifdef UNITY_ADRENO_ES3
					u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
					u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
					if (u_xlatb0) {
						u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
						u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
						u_xlat0.xy = u_xlat0.xy * float2(0.25, 0.25);
						u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
						u_xlat0.xy = frac(abs(u_xlat0.xy));
						u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
						u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
						u_xlat0.xy = u_xlat0.xy * float2(4.0, 4.0);
						u_xlatu0.xy = uint2(u_xlat0.xy);
						u_xlat1.x = dot(_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.y = dot(_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.z = dot(_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat1.w = dot(_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
						u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
						u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
						u_xlat0.x = u_xlat0.x + 0.99000001;
						u_xlat0.x = floor(u_xlat0.x);
						u_xlat0.x = max(u_xlat0.x, 0.0);
						u_xlati0 = int(u_xlat0.x);
						if ((u_xlati0) == 0) { discard; }
						//ENDIF
					}
					//ENDIF
				}
				SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
				SV_Target0.w = vs_COLOR0.w;
				return SV_Target0;
			}
			ENDCG
		}
	}
}
