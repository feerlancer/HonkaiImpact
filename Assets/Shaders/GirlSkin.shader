// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "HonKai/GirlSkin"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_LightMapTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			
			//uniform 	float4 _ProjectionParams;
			//uniform 	float4 _WorldSpaceLightPos0;
			//uniform 	float4x4 glstate_matrix_mvp;
			//uniform 	float4x4 _Object2World;
			//uniform 	float4x4 _World2Object;
			uniform float4 _MainTex_ST = float4(1,1,0,0);
			const static float _UsingDitherAlpha = 0.5;
			const static float _DitherAlpha = 1;

			//uniform 	float3 _WorldSpaceCameraPos;
			//uniform 	float4 _ScreenParams;
			//uniform 	float4 _WorldSpaceLightPos0;
			const static fixed _lightProbToggle=0;
			const static half4 _lightProbColor=half4(0,0,0,0);
			const static float4x4 _DITHERMATRIX=
			{
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				0,0,0,1
			};
			const static half4 _Color=half4(0.9313725, 0.9313725, 0.9313725,0.95);
			const static half _LightArea = 0.51;
			const static half _SecondShadow =0.51;
			const static half3 _FirstShadowMultColor=half3(0.9215686,0.7686275,0.8);
			const static half3 _SecondShadowMultColor=half3(0.8313726,0.6,0.5882353);
			const static half _Shininess=10;
			const static half _SpecMulti=0.2;
			const static half3 _LightSpecColor=half3(1,1,1);
			const static half _BloomFactor = 1;

			uniform sampler2D _LightMapTex;
			uniform sampler2D _MainTex;

			struct appdata
			{
				float4 in_POSITION0 : POSITION0;
				float2 in_TEXCOORD0 : TEXCOORD0;
				float3 in_NORMAL0:NORMAL0;
				half4 in_COLOR0:COLOR0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half4 vs_COLOR0 : COLOR0;
				half vs_COLOR1 : COLOR1;
				float2 vs_TEXCOORD0 : TEXCOORD0;
				float3 vs_TEXCOORD1 : TEXCOORD1;
				float3 vs_TEXCOORD2 : TEXCOORD2;
				float4 vs_TEXCOORD3 : TEXCOORD3;
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
				float4 u_xlat1;
				float3 u_xlat2;
				half u_xlat16_3;
				float u_xlat8;
				bool u_xlatb8;

				//in
				float4 in_POSITION0=v.in_POSITION0;
				float2 in_TEXCOORD0= v.in_TEXCOORD0;
				float3 in_NORMAL0= v.in_NORMAL0;
				half4 in_COLOR0= v.in_COLOR0;
				//out
				float4 vertex;
				half4 vs_COLOR0;
				half vs_COLOR1;
				float2 vs_TEXCOORD0;
				float3 vs_TEXCOORD1;
				float3 vs_TEXCOORD2;
				float4 vs_TEXCOORD3;

				v2f o;
				//o.vs_TEXCOORD0 = TRANSFORM_TEX(v.uv, _MainTex);
				
				//u_xlat0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				//u_xlat0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
				//u_xlat0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
				//u_xlat0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
				//gl_Position = u_xlat0;
				u_xlat0 = UnityObjectToClipPos(in_POSITION0);
				vertex = u_xlat0;

				vs_COLOR0 = in_COLOR0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;

				//TODO flip uv
				vs_TEXCOORD0.y = 1 - vs_TEXCOORD0.y;

				//u_xlat1.x = in_NORMAL0.x * _World2Object[0].x;
				//u_xlat1.y = in_NORMAL0.x * _World2Object[1].x;
				//u_xlat1.z = in_NORMAL0.x * _World2Object[2].x;
				//u_xlat2.x = in_NORMAL0.y * _World2Object[0].y;
				//u_xlat2.y = in_NORMAL0.y * _World2Object[1].y;
				//u_xlat2.z = in_NORMAL0.y * _World2Object[2].y;
				//u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
				//u_xlat2.x = in_NORMAL0.z * _World2Object[0].z;
				//u_xlat2.y = in_NORMAL0.z * _World2Object[1].z;
				//u_xlat2.z = in_NORMAL0.z * _World2Object[2].z;
				//u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
				u_xlat1 = float4(UnityObjectToWorldNormal(in_NORMAL0), 0);

				u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
				u_xlat8 = rsqrt(u_xlat8);
				u_xlat1.xyz = float3(u_xlat8, u_xlat8, u_xlat8)* u_xlat1.xyz;
				vs_TEXCOORD1.xyz = u_xlat1.xyz;

				u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
				u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
				vs_COLOR1 = u_xlat8;

				//u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
				//u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
				//u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
				//u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
				u_xlat1 = mul(unity_ObjectToWorld, in_POSITION0);

				vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
				u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
				u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
				u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
				u_xlatb8 = !!(float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha));
#else
				u_xlatb8 = float4(0.0, 0.0, 0.0, 0.0) != float4(_UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha, _UsingDitherAlpha);
#endif
				vs_TEXCOORD3.xy = lerp(float2(0.0, 0.0), u_xlat0.xy, float2(bool2(u_xlatb8, u_xlatb8)));
				vs_TEXCOORD3.w = u_xlatb8 ? u_xlat0.w : float(0.0);
				vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);

				//update out
				o.vertex=vertex;
				o.vs_COLOR0  = vs_COLOR0;
				o.vs_COLOR1 = vs_COLOR1;
				o.vs_TEXCOORD0 = vs_TEXCOORD0;
				o.vs_TEXCOORD1 = vs_TEXCOORD1;
				o.vs_TEXCOORD2 = vs_TEXCOORD2;
				o.vs_TEXCOORD3 = vs_TEXCOORD3;

				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half4 SV_Target0;

				float2 u_xlat0;
				fixed3 u_xlat10_0;
				int u_xlati0;
				uint2 u_xlatu0;
				bool u_xlatb0;
				float4 u_xlat1;
				half3 u_xlat16_2;
				half3 u_xlat16_3;
				float3 u_xlat4;
				float3 u_xlat5;
				half u_xlat16_5;
				int3 u_xlati5;
				half3 u_xlat16_7;
				bool2 u_xlatb10;
				float u_xlat15;
				int u_xlati16;
				half u_xlat16_17;

				half4 vs_COLOR0= i.vs_COLOR0;
				float2 vs_TEXCOORD0= i.vs_TEXCOORD0;
				half vs_COLOR1= i.vs_COLOR1;
				float3 vs_TEXCOORD1= i.vs_TEXCOORD1;
				float3 vs_TEXCOORD2= i.vs_TEXCOORD2;
				float4 vs_TEXCOORD3= i.vs_TEXCOORD3;

				float4 ImmCB_0_0_0[4];
				ImmCB_0_0_0[0] = float4(1.0, 0.0, 0.0, 0.0);
				ImmCB_0_0_0[1] = float4(0.0, 1.0, 0.0, 0.0);
				ImmCB_0_0_0[2] = float4(0.0, 0.0, 1.0, 0.0);
				ImmCB_0_0_0[3] = float4(0.0, 0.0, 0.0, 1.0);
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
						u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
						u_xlat0.xy = frac(abs(u_xlat0.xy));
						u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
						u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
						u_xlat0.xy = u_xlat0.xy * float2(4.0, 4.0);
						u_xlatu0.xy = int2(u_xlat0.xy);
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
				u_xlat10_0.xyz = tex2D(_LightMapTex, vs_TEXCOORD0.xy).xyz;
				u_xlat1.xyz = tex2D(_MainTex, vs_TEXCOORD0.xy).xyz;
				u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
				u_xlat15 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
				u_xlat15 = floor(u_xlat15);
				u_xlat5.z = max(u_xlat15, 0.0);
				u_xlat16_7.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
				u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_SecondShadow);
				u_xlat16_7.x = u_xlat16_7.x + 1.0;
				u_xlat16_7.x = floor(u_xlat16_7.x);
				u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
				u_xlati16 = int(u_xlat16_7.x);
				u_xlat16_7.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
				u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
				u_xlat16_7.xyz = (int(u_xlati16) != 0) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
				u_xlat5.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
				u_xlat5.x = floor(u_xlat5.x);
				u_xlat5.x = max(u_xlat5.x, 0.0);
				u_xlati5.xz = int2(u_xlat5.xz);
				u_xlat4.xy = u_xlat16_2.xx * float2(1.20000005, 1.25) + float2(-0.100000001, -0.125);
				u_xlat16_2.x = (u_xlati5.x != 0) ? u_xlat4.y : u_xlat4.x;
				u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
				u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
				u_xlat16_2.x = u_xlat16_2.x + 1.0;
				u_xlat16_2.x = floor(u_xlat16_2.x);
				u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
				u_xlati5.x = int(u_xlat16_2.x);
				u_xlat16_3.xyz = (u_xlati5.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
				u_xlat16_2.xyz = (u_xlati5.z != 0) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
				u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
				u_xlat5.x = rsqrt(u_xlat5.x);
				u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
				u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
				u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
				u_xlat5.x = rsqrt(u_xlat5.x);
				u_xlat4.xyz = u_xlat4.xyz * u_xlat5.xxx + _WorldSpaceLightPos0.xyz;
				u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
				u_xlat5.x = rsqrt(u_xlat5.x);
				u_xlat4.xyz = u_xlat5.xxx * u_xlat4.xyz;
				u_xlat16_17 = dot(u_xlat1.xyz, u_xlat4.xyz);
				u_xlat16_17 = max(u_xlat16_17, 0.0);
				u_xlat16_17 = log2(u_xlat16_17);
				u_xlat16_17 = u_xlat16_17 * _Shininess;
				u_xlat16_17 = exp2(u_xlat16_17);
				u_xlat16_5 = (-u_xlat10_0.z) + 1.0;
				u_xlat16_5 = (-u_xlat16_17) + u_xlat16_5;
				u_xlat5.x = u_xlat16_5 + 1.0;
				u_xlat5.x = floor(u_xlat5.x);
				u_xlat5.x = max(u_xlat5.x, 0.0);
				u_xlati5.x = int(u_xlat5.x);
				u_xlat16_3.xyz = float3(_SpecMulti * _LightSpecColor.xxyz.y, _SpecMulti * _LightSpecColor.xxyz.z, _SpecMulti * float(_LightSpecColor.z));
				u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
				u_xlat16_3.xyz = (u_xlati5.x != 0) ? float3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
				u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
				u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
				u_xlatb0 = !!(0.5<_lightProbToggle);
#else
				u_xlatb0 = 0.5<_lightProbToggle;
#endif
				u_xlat16_3.xyz = (bool(u_xlatb0)) ? _lightProbColor.xyz : float3(1.0, 1.0, 1.0);
				SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
				SV_Target0.w = _BloomFactor;

				return SV_Target0;
			}
			ENDCG
		}
	}
}
