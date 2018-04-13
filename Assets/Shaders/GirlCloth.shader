// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

Shader "HonKai/GirlCloth"
{
	Properties
	{
		_MainTex ("MainTex", 2D) = "white" {}
		_LightMapTex ("LightMap", 2D) = "white"{}
		_BloomMaskTex("BloomMap",2D)="white"{}
		_FirstShadowMultColor("FirstShadowMultColor",Vector) = (0.73, 0.6, 0.65,0)
		_SecondShadowMultColor("SecondShadowMultColor",Vector)=(0.65, 0.45, 0.55,0)

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag

			bool4 notEqual(float4 a, float4 b)
			{
				return bool4(a.x!=b.x,a.y!=b.y,a.z!=b.z,a.w!=b.w);
			}
			bool4 greaterThanEqual(float4 a, float4 b)
			{
				return bool4(a.x>=b.x,a.y>=b.y,a.z>=b.z,a.w>=b.w);
			}
			#define inversesqrt rsqrt
			#define mix lerp

			struct appdata
			{
			    float4 in_POSITION0:POSITION;
			    float3 in_NORMAL0:NORMAL0;
			    float4 in_TEXCOORD0:TEXCOORD0;
			    half4  in_COLOR0:COLOR0;
			};

			struct v2f
			{
			    float4 vertex : SV_POSITION;
			    half4 vs_COLOR0:COLOR0;
			    half vs_COLOR1:COLOR1;
			    half2 vs_TEXCOORD0:TEXCOORD0; //uv
			    half3 vs_TEXCOORD1:TEXCOORD1; //normal
			    float3 vs_TEXCOORD2:TEXCOORD2;//world position
			    float4 vs_TEXCOORD3:TEXCOORD3;//?
			    half2 vs_TEXCOORD5:TEXCOORD5;//?
			};

			v2f vert (appdata v)
			{
				//VS uniforms
	//			float4 _ProjectionParams;
	//			float4x4 glstate_matrix_mvp;
	//			float4x4 _Object2World;
	//			float4x4 _World2Object;
				float _UsingDitherAlpha = 0;

				float _DitherAlpha = 1;

				float _UsingBloomMask = 0;
				float4 _BloomMaskTex_ST = float4(1,1,0,0);


				//unity's fck vars
				float4 u_xlat0;
				float4 u_xlat1;
				float4 u_xlat2;
				float3 u_xlat3;
				half u_xlat16_4;
				float u_xlat10;
				bool2 u_xlatb11;

				//in
			    float4 in_POSITION0=v.in_POSITION0;
			    float3 in_NORMAL0=v.in_NORMAL0;
			    float4 in_TEXCOORD0=v.in_TEXCOORD0;
			    half4  in_COLOR0=v.in_COLOR0;

			    //out
			    float4 vertex;
			    half4 vs_COLOR0;
			    half2 vs_TEXCOORD0;
			    half2 vs_TEXCOORD5;
			    half3 vs_TEXCOORD1;
			    half vs_COLOR1;
			    float3 vs_TEXCOORD2;
			    float4 vs_TEXCOORD3;

			 	v2f o;
			 	//glsl assume uniform mat is column-major
//			    u_xlat0 = in_POSITION0.yyyy * UNITY_MATRIX_MVP[1];
//			    u_xlat0 = UNITY_MATRIX_MVP[0] * in_POSITION0.xxxx + u_xlat0;
//			    u_xlat0 = UNITY_MATRIX_MVP[2] * in_POSITION0.zzzz + u_xlat0;
//			    u_xlat0 = UNITY_MATRIX_MVP[3] * in_POSITION0.wwww + u_xlat0;

			    u_xlat0 = UnityObjectToClipPos(in_POSITION0);
				//float4x4 glstate_matrix_mvp123 =
				//{
				//	-0.5,-4.42,0.015768,0.15767,
				//	0.5,-0.253,-0.9782274,-0.978,
				//	2.438,-0.858,0.207,0.207,
				//	-2.028,-1.75,4.839,5.4387
				//};

			    vertex = u_xlat0;
			    vs_COLOR0 = in_COLOR0;
			    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
			    u_xlat1.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
			    u_xlatb11.xy = notEqual(float4(0.0, 0.0, 0.0, 0.0), float4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask)).xy;

			    vs_TEXCOORD5.xy = (u_xlatb11.y) ? u_xlat1.xy : float2(0.0, 0.0);

//			    u_xlat2.x = in_NORMAL0.x * unity_WorldToObject[0].x;
//			    u_xlat2.y = in_NORMAL0.x * unity_WorldToObject[1].x;
//			    u_xlat2.z = in_NORMAL0.x * unity_WorldToObject[2].x;
//			    u_xlat3.x = in_NORMAL0.y * unity_WorldToObject[0].y;
//			    u_xlat3.y = in_NORMAL0.y * unity_WorldToObject[1].y;
//			    u_xlat3.z = in_NORMAL0.y * unity_WorldToObject[2].y;
//			    u_xlat1.xyw = u_xlat2.xyz + u_xlat3.xyz;
//			    u_xlat2.x = in_NORMAL0.z * unity_WorldToObject[0].z;
//			    u_xlat2.y = in_NORMAL0.z * unity_WorldToObject[1].z;
//			    u_xlat2.z = in_NORMAL0.z * unity_WorldToObject[2].z;
//			    u_xlat1.xyw = u_xlat1.xyw + u_xlat2.xyz;

				//TODO
				//float4x4 unity_WorldToObject11 = 
				//{
				//	0.197,-0.2,-0.9596,0,
				//	-0.98,-0.02,-0.197,0,
				//	0.01844,0.9795,-0.2,0,
				//	0.75,-4.62,1.95,1
				//};
				//u_xlat2.x = in_NORMAL0.x * unity_WorldToObject11[0].x;
				//u_xlat2.y = in_NORMAL0.x * unity_WorldToObject11[1].x;
				//u_xlat2.z = in_NORMAL0.x * unity_WorldToObject11[2].x;
				//u_xlat3.x = in_NORMAL0.y * unity_WorldToObject11[0].y;
				//u_xlat3.y = in_NORMAL0.y * unity_WorldToObject11[1].y;
				//u_xlat3.z = in_NORMAL0.y * unity_WorldToObject11[2].y;
				//u_xlat1.xyw = u_xlat2.xyz + u_xlat3.xyz;
				//u_xlat2.x = -in_NORMAL0.z * unity_WorldToObject11[0].z;
				//u_xlat2.y = -in_NORMAL0.z * unity_WorldToObject11[1].z;
				//u_xlat2.z = -in_NORMAL0.z * unity_WorldToObject11[2].z;
				//u_xlat1.xyw = u_xlat1.xyw + u_xlat2.xyz;



				u_xlat1 = float4(UnityObjectToWorldNormal(in_NORMAL0),0);
				u_xlat1.xyw = u_xlat1.xyz;//wut fck unity use xyw?

			    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
			    u_xlat10 = inversesqrt(u_xlat10);
			    u_xlat1.xyw = float3(u_xlat10,u_xlat10,u_xlat10) * u_xlat1.xyw;

				u_xlat16_4 = dot(u_xlat1.xyw, _WorldSpaceLightPos0.xyz);

			    vs_TEXCOORD1.xyz = u_xlat1.xyw;
			    u_xlat10 = u_xlat16_4 * 0.497500002 + 0.5;
			    vs_COLOR1 = u_xlat10;

//glsl assume uniform mat is column-major
//			    u_xlat2 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
//			    u_xlat2 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
//			    u_xlat2 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
//			    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
			    u_xlat2 = mul(unity_ObjectToWorld,in_POSITION0);

			    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
			    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
			    u_xlat2.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
			    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
			    vs_TEXCOORD3.xyw = mix(float3(0.0, 0.0, 0.0), u_xlat0.xyw, float3(u_xlatb11.xxx));
			    vs_TEXCOORD3.z = u_xlatb11.x ? _DitherAlpha : float(0.0);

			    o.vertex = vertex;
			    o.vs_COLOR0=vs_COLOR0;
			    o.vs_TEXCOORD0=vs_TEXCOORD0;
			    o.vs_TEXCOORD5=vs_TEXCOORD5;
			    o.vs_TEXCOORD1=vs_TEXCOORD1;
			    o.vs_COLOR1=vs_COLOR1;
			    o.vs_TEXCOORD2=vs_TEXCOORD2;
			    o.vs_TEXCOORD3=vs_TEXCOORD3;
			   
			    return o;
			}



			sampler2D _LightMapTex;
			sampler2D _MainTex;
			sampler2D _BloomMaskTex;
			uniform half3 _FirstShadowMultColor;
			uniform half3 _SecondShadowMultColor;
			half4 frag (v2f i) : SV_Target
			{
			//uniforms
//			 	float3 _WorldSpaceCameraPos;
//			 	float4 _ScreenParams;
			 	float4x4 _DITHERMATRIX = 
			 	{
			 	    { 1, 0, 0, 0 },
				    { 0, 1, 0, 0 },
				    { 0, 0, 1, 0 },
				    { 0, 0, 0, 1 }
			 	};
			 	half4 _Color = half4(0.93,0.93,0.93,0.95);
			 	half _LightArea=0.51;
			 	half _SecondShadow = 0.51;
			 	//half3 _FirstShadowMultColor = half3(0.73,0.6,0.65);
			 	//half3 _SecondShadowMultColor = half3(0.65,0.45,0.55);
			 	//_FirstShadowMultColor = 0.9;
			 	half _Shininess=10;
			 	half _SpecMulti=0.2;
			 	half3 _LightSpecColor=half3(1,1,1);
			 	half _BloomFactor=1;
			 	half _Emission=1;
			 	half _EmissionBloomFactor=0;
			 	float _UsingDitherAlpha=0;
			 	float _UsingBloomMask=0;

			 	//unity's fck vars
			 	float4 ImmCB_0_0_0[4];

				half4 u_xlat16_0;
				fixed4 u_xlat10_0;
				half u_xlat16_1;
				fixed u_xlat10_1;
				bool2 u_xlatb1;
				float2 u_xlat2;
				half4 u_xlat16_2;
				fixed3 u_xlat10_2;
				int u_xlati2;
				uint2 u_xlatu2;
				bool u_xlatb2;
				float4 u_xlat3;
				int u_xlati3;
				half3 u_xlat16_4;
				half3 u_xlat16_5;
				float3 u_xlat8;
				half u_xlat16_8;
				int3 u_xlati8;
				half3 u_xlat16_10;
				bool2 u_xlatb14;
				float u_xlat20;
				half u_xlat16_22;

				half4 SV_Target0;
				//in
				half4 vs_COLOR0 = i.vs_COLOR0;
				half2 vs_TEXCOORD0= half2(i.vs_TEXCOORD0.x,1-i.vs_TEXCOORD0.y);
				half2 vs_TEXCOORD5= i.vs_TEXCOORD5;
				half3 vs_TEXCOORD1= i.vs_TEXCOORD1;
				half vs_COLOR1= i.vs_COLOR1;
				float3 vs_TEXCOORD2= i.vs_TEXCOORD2;
				float4 vs_TEXCOORD3= i.vs_TEXCOORD3;


				ImmCB_0_0_0[0] = float4(1.0, 0.0, 0.0, 0.0);
				ImmCB_0_0_0[1] = float4(0.0, 1.0, 0.0, 0.0);
				ImmCB_0_0_0[2] = float4(0.0, 0.0, 1.0, 0.0);
				ImmCB_0_0_0[3] = float4(0.0, 0.0, 0.0, 1.0);
			    u_xlat10_0 = tex2D(_MainTex, vs_TEXCOORD0.xy);
			    u_xlatb1.xy = notEqual(float4(0.0, 0.0, 0.0, 0.0), float4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
			    if(u_xlatb1.x){
			        u_xlat10_1 = tex2D(_BloomMaskTex, vs_TEXCOORD5.xy).x;
			        u_xlat16_1 = u_xlat10_0.w * u_xlat10_1;
			        u_xlat16_1 = u_xlat16_1;
			    } else {
			        u_xlat16_1 = u_xlat10_0.w;
			    }
			    if(u_xlatb1.y){
			#ifdef UNITY_ADRENO_ES3
			        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
			#else
			        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
			#endif
			        if(u_xlatb2){
			            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
			            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
			            u_xlat2.xy = u_xlat2.xy * float2(0.25, 0.25);
			            u_xlatb14.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
			            u_xlat2.xy = frac(abs(u_xlat2.xy));
			            u_xlat2.x = (u_xlatb14.x) ? u_xlat2.x : (-u_xlat2.x);
			            u_xlat2.y = (u_xlatb14.y) ? u_xlat2.y : (-u_xlat2.y);
			            u_xlat2.xy = u_xlat2.xy * float2(4.0, 4.0);
			            u_xlatu2.xy = uint2(u_xlat2.xy);
			            u_xlat3.x = dot(_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
			            u_xlat3.y = dot(_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
			            u_xlat3.z = dot(_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
			            u_xlat3.w = dot(_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
			            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
			            u_xlat2.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat2.x);
			            u_xlat2.x = u_xlat2.x + 0.99000001;
			            u_xlat2.x = floor(u_xlat2.x);
			            u_xlat2.x = max(u_xlat2.x, 0.0);
			            u_xlati2 = int(u_xlat2.x);
			            if((u_xlati2)==0){discard;}
			        }
			    }
			    u_xlat10_2.xyz = tex2D(_LightMapTex, vs_TEXCOORD0.xy).xyz;
			    u_xlat16_4.x = u_xlat10_2.y * vs_COLOR0.x;
			    u_xlat20 = vs_COLOR0.x * u_xlat10_2.y + 0.909999967;
			    u_xlat20 = floor(u_xlat20);
			    u_xlat8.z = max(u_xlat20, 0.0);
			    u_xlat16_10.x = vs_COLOR0.x * u_xlat10_2.y + vs_COLOR1;
			    u_xlat16_10.x = u_xlat16_10.x * 0.5 + (-_SecondShadow);
			    u_xlat16_10.x = u_xlat16_10.x + 1.0;
			    u_xlat16_10.x = floor(u_xlat16_10.x);
			    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
			    u_xlati3 = int(u_xlat16_10.x);
			    u_xlat16_10.xyz = u_xlat10_0.xyz * _SecondShadowMultColor.xyz;
			    u_xlat16_5.xyz = u_xlat10_0.xyz * _FirstShadowMultColor.xyz;
			    u_xlat16_10.xyz = (int(u_xlati3) != 0) ? u_xlat16_5.xyz : u_xlat16_10.xyz;
			    u_xlat8.x = (-vs_COLOR0.x) * u_xlat10_2.y + 1.5;
			    u_xlat8.x = floor(u_xlat8.x);
			    u_xlat8.x = max(u_xlat8.x, 0.0);
			    u_xlati8.xz = int2(u_xlat8.xz);
			    u_xlat3.xy = u_xlat16_4.xx * float2(1.20000005, 1.25) + float2(-0.100000001, -0.125);
			    u_xlat16_4.x = (u_xlati8.x != 0) ? u_xlat3.y : u_xlat3.x;
			    u_xlat16_4.x = u_xlat16_4.x + vs_COLOR1;
			    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_LightArea);
			    u_xlat16_4.x = u_xlat16_4.x + 1.0;
			    u_xlat16_4.x = floor(u_xlat16_4.x);
			    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
			    u_xlati8.x = int(u_xlat16_4.x);
			    u_xlat16_5.xyz = (u_xlati8.x != 0) ? u_xlat10_0.xyz : u_xlat16_5.xyz;
			    u_xlat16_4.xyz = (u_xlati8.z != 0) ? u_xlat16_5.xyz : u_xlat16_10.xyz;
			    u_xlat16_22 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
			    u_xlat16_22 = rsqrt(u_xlat16_22);
			    u_xlat16_5.xyz = float3(u_xlat16_22,u_xlat16_22,u_xlat16_22) * vs_TEXCOORD1.xyz;
			    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;

			    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
			    u_xlat8.x = rsqrt(u_xlat8.x);

				u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + _WorldSpaceLightPos0.xyz;

			    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
			    u_xlat8.x = rsqrt(u_xlat8.x);
			    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
			    u_xlat16_22 = dot(u_xlat16_5.xyz, u_xlat3.xyz);
			    u_xlat16_22 = max(u_xlat16_22, 0.0);
			    u_xlat16_22 = log2(u_xlat16_22);
			    u_xlat16_22 = u_xlat16_22 * _Shininess;
			    u_xlat16_22 = exp2(u_xlat16_22);
			    u_xlat16_8 = (-u_xlat10_2.z) + 1.0;
			    u_xlat16_8 = (-u_xlat16_22) + u_xlat16_8;
			    u_xlat8.x = u_xlat16_8 + 1.0;
			    u_xlat8.x = floor(u_xlat8.x);
			    u_xlat8.x = max(u_xlat8.x, 0.0);
			    u_xlati8.x = int(u_xlat8.x);
			    u_xlat16_5.xyz = float3(_SpecMulti * _LightSpecColor.xxyz.y, _SpecMulti * _LightSpecColor.xxyz.z, _SpecMulti * float(_LightSpecColor.z));
			    u_xlat16_5.xyz = u_xlat10_2.xxx * u_xlat16_5.xyz;
			    u_xlat16_5.xyz = (u_xlati8.x != 0) ? float3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
			    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
			    u_xlat16_2.xyz = u_xlat16_4.xyz * _Color.xyz;
			    u_xlat16_2.w = _Color.w * _BloomFactor;
			    u_xlat16_0.xyz = u_xlat10_0.xyz * float3(float3(_Emission, _Emission, _Emission)) + (-u_xlat16_2.xyz);
			    u_xlat16_0.w = (-_BloomFactor) * _Color.w + _EmissionBloomFactor;
			    SV_Target0 = float4(u_xlat16_1,u_xlat16_1,u_xlat16_1,u_xlat16_1) * u_xlat16_0 + u_xlat16_2;

			    return SV_Target0;
			}
			ENDCG
		}
	}
}
