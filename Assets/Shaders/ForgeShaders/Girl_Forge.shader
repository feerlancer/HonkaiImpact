// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:1,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:38048,y:33327,varname:node_3138,prsc:2|custl-5388-OUT;n:type:ShaderForge.SFN_Tex2d,id:8072,x:33629,y:32254,varname:node_8072,prsc:2,tex:9b1964bf6d1106846813a186ec939418,ntxv:0,isnm:False|UVIN-9213-UVOUT,TEX-9972-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:9972,x:33388,y:32311,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_9972,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9b1964bf6d1106846813a186ec939418,ntxv:1,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:481,x:32935,y:32657,ptovrint:False,ptlb:LightMap,ptin:_LightMap,varname:node_481,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e26a5447b7ec55845b2a7e3c0271c530,ntxv:0,isnm:False;n:type:ShaderForge.SFN_VertexColor,id:4757,x:33312,y:32899,cmnt:顶点色,varname:node_4757,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:9213,x:32989,y:32254,varname:node_9213,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_NormalVector,id:6533,x:33972,y:33192,prsc:2,pt:False;n:type:ShaderForge.SFN_Normalize,id:1380,x:34158,y:33192,varname:node_1380,prsc:2|IN-6533-OUT;n:type:ShaderForge.SFN_LightVector,id:344,x:33972,y:33351,varname:node_344,prsc:2;n:type:ShaderForge.SFN_Normalize,id:8727,x:34158,y:33351,varname:node_8727,prsc:2|IN-344-OUT;n:type:ShaderForge.SFN_Dot,id:1720,x:34351,y:33252,varname:node_1720,prsc:2,dt:4|A-1380-OUT,B-8727-OUT;n:type:ShaderForge.SFN_Tex2d,id:5899,x:33205,y:32619,cmnt:SpecularPower ShadowMask SpecularMask,varname:node_5899,prsc:2,tex:e26a5447b7ec55845b2a7e3c0271c530,ntxv:0,isnm:False|UVIN-9213-UVOUT,TEX-481-TEX;n:type:ShaderForge.SFN_Multiply,id:2739,x:33524,y:32826,varname:node_2739,prsc:2|A-5547-OUT,B-4757-R;n:type:ShaderForge.SFN_Vector1,id:1868,x:33942,y:32875,varname:node_1868,prsc:2,v1:0.5;n:type:ShaderForge.SFN_If,id:7353,x:34204,y:32821,varname:node_7353,prsc:2|A-6201-OUT,B-1868-OUT,GT-7552-OUT,EQ-1663-OUT,LT-1663-OUT;n:type:ShaderForge.SFN_Multiply,id:4338,x:33599,y:33116,varname:node_4338,prsc:2|A-4236-OUT,B-7987-OUT;n:type:ShaderForge.SFN_Vector1,id:7987,x:33376,y:33192,varname:node_7987,prsc:2,v1:1.25;n:type:ShaderForge.SFN_Subtract,id:1663,x:33804,y:33116,varname:node_1663,prsc:2|A-4338-OUT,B-9436-OUT;n:type:ShaderForge.SFN_Vector1,id:9436,x:33599,y:33288,varname:node_9436,prsc:2,v1:0.125;n:type:ShaderForge.SFN_Multiply,id:2669,x:33766,y:32566,varname:node_2669,prsc:2|A-975-OUT,B-8554-OUT;n:type:ShaderForge.SFN_Vector1,id:975,x:33602,y:32566,varname:node_975,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Subtract,id:7552,x:33968,y:32630,varname:node_7552,prsc:2|A-2669-OUT,B-2443-OUT;n:type:ShaderForge.SFN_Vector1,id:2443,x:33766,y:32735,varname:node_2443,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Add,id:8598,x:34469,y:32821,varname:node_8598,prsc:2|A-7353-OUT,B-1720-OUT;n:type:ShaderForge.SFN_Multiply,id:3495,x:34703,y:32821,varname:node_3495,prsc:2|A-8598-OUT,B-5478-OUT;n:type:ShaderForge.SFN_Vector1,id:5478,x:34527,y:33001,varname:node_5478,prsc:2,v1:0.5;n:type:ShaderForge.SFN_If,id:5298,x:35493,y:32846,varname:node_5298,prsc:2|A-3495-OUT,B-5345-OUT,GT-4009-OUT,EQ-4009-OUT,LT-8949-OUT;n:type:ShaderForge.SFN_Multiply,id:8949,x:35039,y:33046,varname:node_8949,prsc:2|A-2837-OUT,B-8964-XYZ;n:type:ShaderForge.SFN_If,id:3337,x:36051,y:33044,varname:node_3337,prsc:2|A-1175-OUT,B-9416-OUT,GT-5298-OUT,EQ-5298-OUT,LT-6017-OUT;n:type:ShaderForge.SFN_Vector1,id:9416,x:35842,y:32937,varname:node_9416,prsc:2,v1:0.09;n:type:ShaderForge.SFN_Add,id:5398,x:34939,y:33550,varname:node_5398,prsc:2|A-6711-OUT,B-1720-OUT;n:type:ShaderForge.SFN_Multiply,id:5501,x:35364,y:33547,varname:node_5501,prsc:2|A-5398-OUT,B-6454-OUT;n:type:ShaderForge.SFN_Vector1,id:6454,x:35131,y:33653,varname:node_6454,prsc:2,v1:0.5;n:type:ShaderForge.SFN_If,id:6017,x:35819,y:33545,varname:node_6017,prsc:2|A-5501-OUT,B-6406-OUT,GT-8949-OUT,EQ-8949-OUT,LT-3941-OUT;n:type:ShaderForge.SFN_Multiply,id:3941,x:35425,y:33764,varname:node_3941,prsc:2|A-6211-OUT,B-8039-XYZ;n:type:ShaderForge.SFN_Multiply,id:1842,x:36380,y:33044,cmnt:FinalDiffuse,varname:node_1842,prsc:2|A-3337-OUT,B-9113-OUT;n:type:ShaderForge.SFN_Vector4Property,id:8964,x:34818,y:33144,ptovrint:False,ptlb:FirstShadowMultColor,ptin:_FirstShadowMultColor,varname:node_8964,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.65,v2:0.45,v3:0.549,v4:0;n:type:ShaderForge.SFN_Vector4Property,id:8039,x:35191,y:33867,ptovrint:False,ptlb:SecondShadowMultColor,ptin:_SecondShadowMultColor,varname:node_8039,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.65,v2:0.45,v3:0.549,v4:0;n:type:ShaderForge.SFN_Subtract,id:7396,x:37092,y:33388,varname:node_7396,prsc:2|A-8157-OUT,B-7713-OUT;n:type:ShaderForge.SFN_Multiply,id:9560,x:37510,y:33390,varname:node_9560,prsc:2|A-7396-OUT,B-1537-OUT;n:type:ShaderForge.SFN_Add,id:5388,x:37743,y:33656,varname:node_5388,prsc:2|A-9560-OUT,B-7713-OUT;n:type:ShaderForge.SFN_HalfVector,id:8520,x:33393,y:34105,varname:node_8520,prsc:2;n:type:ShaderForge.SFN_Normalize,id:6084,x:33568,y:34105,varname:node_6084,prsc:2|IN-8520-OUT;n:type:ShaderForge.SFN_Clamp01,id:9147,x:33771,y:34105,varname:node_9147,prsc:2|IN-6084-OUT;n:type:ShaderForge.SFN_Log,id:3541,x:33980,y:34105,varname:node_3541,prsc:2,lt:1|IN-9147-OUT;n:type:ShaderForge.SFN_Multiply,id:4709,x:34148,y:34129,varname:node_4709,prsc:2|A-3541-OUT,B-7609-OUT;n:type:ShaderForge.SFN_Vector1,id:7609,x:33980,y:34273,cmnt:Shiness,varname:node_7609,prsc:2,v1:10;n:type:ShaderForge.SFN_Exp,id:5628,x:34346,y:34129,varname:node_5628,prsc:2,et:1|IN-4709-OUT;n:type:ShaderForge.SFN_If,id:7785,x:35310,y:34341,varname:node_7785,prsc:2|A-3660-OUT,B-2494-OUT,GT-7924-OUT,EQ-6199-OUT,LT-6199-OUT;n:type:ShaderForge.SFN_Vector1,id:3660,x:34495,y:34062,varname:node_3660,prsc:2,v1:1;n:type:ShaderForge.SFN_Add,id:2494,x:34564,y:34209,varname:node_2494,prsc:2|A-5628-OUT,B-6471-OUT;n:type:ShaderForge.SFN_Vector1,id:6199,x:34864,y:34430,varname:node_6199,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:114,x:34247,y:34390,cmnt:_SpecMulti,varname:node_114,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Multiply,id:7924,x:34564,y:34369,cmnt:SpecColor,varname:node_7924,prsc:2|A-8771-OUT,B-114-OUT,C-5151-OUT;n:type:ShaderForge.SFN_Vector1,id:5151,x:34247,y:34489,cmnt:_LightSpecColor,varname:node_5151,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:9395,x:35902,y:34317,cmnt:FinalSpec,varname:node_9395,prsc:2|A-9603-OUT,B-7785-OUT;n:type:ShaderForge.SFN_Add,id:7713,x:36764,y:33672,cmnt:FinalColor,varname:node_7713,prsc:2|A-6798-OUT,B-2839-OUT;n:type:ShaderForge.SFN_Set,id:7612,x:33922,y:32252,varname:MainColor,prsc:2|IN-8072-RGB;n:type:ShaderForge.SFN_Get,id:4009,x:35104,y:32943,varname:node_4009,prsc:2|IN-7612-OUT;n:type:ShaderForge.SFN_Get,id:6211,x:35170,y:33764,varname:node_6211,prsc:2|IN-7612-OUT;n:type:ShaderForge.SFN_Get,id:8157,x:36725,y:33386,varname:node_8157,prsc:2|IN-7612-OUT;n:type:ShaderForge.SFN_Get,id:2837,x:34797,y:33046,varname:node_2837,prsc:2|IN-7612-OUT;n:type:ShaderForge.SFN_Set,id:3497,x:33922,y:32334,varname:MainAlpha,prsc:2|IN-8072-A;n:type:ShaderForge.SFN_Get,id:1537,x:37266,y:33426,varname:node_1537,prsc:2|IN-3497-OUT;n:type:ShaderForge.SFN_Set,id:6540,x:33446,y:32566,varname:SpecStrength,prsc:2|IN-5899-R;n:type:ShaderForge.SFN_Set,id:8244,x:33458,y:32621,varname:ShadowMask,prsc:2|IN-5899-G;n:type:ShaderForge.SFN_Set,id:1086,x:33458,y:32684,varname:SpecMask,prsc:2|IN-5899-B;n:type:ShaderForge.SFN_Get,id:5547,x:33291,y:32826,varname:node_5547,prsc:2|IN-8244-OUT;n:type:ShaderForge.SFN_Get,id:8771,x:34226,y:34304,varname:node_8771,prsc:2|IN-6540-OUT;n:type:ShaderForge.SFN_Get,id:6471,x:34364,y:34274,varname:node_6471,prsc:2|IN-1086-OUT;n:type:ShaderForge.SFN_Set,id:5395,x:33745,y:32826,varname:ShadowMask_x_VertexColor,prsc:2|IN-2739-OUT;n:type:ShaderForge.SFN_Get,id:8554,x:33602,y:32648,varname:node_8554,prsc:2|IN-5395-OUT;n:type:ShaderForge.SFN_Get,id:4236,x:33355,y:33116,varname:node_4236,prsc:2|IN-5395-OUT;n:type:ShaderForge.SFN_Get,id:6201,x:33924,y:32800,varname:node_6201,prsc:2|IN-5395-OUT;n:type:ShaderForge.SFN_Get,id:1175,x:35821,y:32825,varname:node_1175,prsc:2|IN-5395-OUT;n:type:ShaderForge.SFN_Get,id:6711,x:34640,y:33550,varname:node_6711,prsc:2|IN-5395-OUT;n:type:ShaderForge.SFN_Set,id:7979,x:36548,y:33044,varname:FinalDiffuse,prsc:2|IN-1842-OUT;n:type:ShaderForge.SFN_Get,id:6798,x:36515,y:33672,varname:node_6798,prsc:2|IN-7979-OUT;n:type:ShaderForge.SFN_Set,id:4720,x:36146,y:34317,varname:FinalSpec,prsc:2|IN-9395-OUT;n:type:ShaderForge.SFN_Get,id:2839,x:36515,y:33746,varname:node_2839,prsc:2|IN-4720-OUT;n:type:ShaderForge.SFN_Set,id:8021,x:33156,y:33228,varname:LightColor,prsc:2|IN-376-OUT;n:type:ShaderForge.SFN_Get,id:5421,x:36017,y:33242,varname:node_5421,prsc:2|IN-8021-OUT;n:type:ShaderForge.SFN_Get,id:4665,x:35506,y:34236,varname:node_4665,prsc:2|IN-8021-OUT;n:type:ShaderForge.SFN_Vector4,id:376,x:32839,y:33229,varname:node_376,prsc:2,v1:0.93,v2:0.93,v3:0.93,v4:0.95;n:type:ShaderForge.SFN_Vector1,id:4676,x:32942,y:33100,varname:node_4676,prsc:2,v1:0.51;n:type:ShaderForge.SFN_Set,id:5993,x:33156,y:33100,varname:FirstShadowArea,prsc:2|IN-4676-OUT;n:type:ShaderForge.SFN_Vector1,id:3736,x:32942,y:33004,varname:node_3736,prsc:2,v1:0.51;n:type:ShaderForge.SFN_Set,id:5937,x:33156,y:33004,varname:SecondShaodwArea,prsc:2|IN-3736-OUT;n:type:ShaderForge.SFN_Get,id:5345,x:34899,y:32857,varname:node_5345,prsc:2|IN-5993-OUT;n:type:ShaderForge.SFN_Get,id:1471,x:35557,y:33700,varname:node_1471,prsc:2|IN-5937-OUT;n:type:ShaderForge.SFN_Get,id:6406,x:35501,y:33608,varname:node_6406,prsc:2|IN-5937-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9113,x:36207,y:33196,varname:node_9113,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-5421-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9603,x:35690,y:34190,varname:node_9603,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-4665-OUT;proporder:481-9972-8964-8039;pass:END;sub:END;*/

Shader "Shader Forge/Girl_Forge" {
    Properties {
        _LightMap ("LightMap", 2D) = "white" {}
        _MainTex ("MainTex", 2D) = "gray" {}
        _FirstShadowMultColor ("FirstShadowMultColor", Vector) = (0.65,0.45,0.549,0)
        _SecondShadowMultColor ("SecondShadowMultColor", Vector) = (0.65,0.45,0.549,0)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _LightMap; uniform float4 _LightMap_ST;
            uniform float4 _FirstShadowMultColor;
            uniform float4 _SecondShadowMultColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float4 node_8072 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 MainColor = node_8072.rgb;
                float4 node_5899 = tex2D(_LightMap,TRANSFORM_TEX(i.uv0, _LightMap)); // SpecularPower ShadowMask SpecularMask
                float ShadowMask = node_5899.g;
                float ShadowMask_x_VertexColor = (ShadowMask*i.vertexColor.r);
                float node_3337_if_leA = step(ShadowMask_x_VertexColor,0.09);
                float node_3337_if_leB = step(0.09,ShadowMask_x_VertexColor);
                float node_1720 = 0.5*dot(normalize(i.normalDir),normalize(lightDirection))+0.5;
                float SecondShaodwArea = 0.51;
                float node_6017_if_leA = step(((ShadowMask_x_VertexColor+node_1720)*0.5),SecondShaodwArea);
                float node_6017_if_leB = step(SecondShaodwArea,((ShadowMask_x_VertexColor+node_1720)*0.5));
                float3 node_8949 = (MainColor*_FirstShadowMultColor.rgb);
                float node_7353_if_leA = step(ShadowMask_x_VertexColor,0.5);
                float node_7353_if_leB = step(0.5,ShadowMask_x_VertexColor);
                float node_1663 = ((ShadowMask_x_VertexColor*1.25)-0.125);
                float FirstShadowArea = 0.51;
                float node_5298_if_leA = step(((lerp((node_7353_if_leA*node_1663)+(node_7353_if_leB*((1.2*ShadowMask_x_VertexColor)-0.1)),node_1663,node_7353_if_leA*node_7353_if_leB)+node_1720)*0.5),FirstShadowArea);
                float node_5298_if_leB = step(FirstShadowArea,((lerp((node_7353_if_leA*node_1663)+(node_7353_if_leB*((1.2*ShadowMask_x_VertexColor)-0.1)),node_1663,node_7353_if_leA*node_7353_if_leB)+node_1720)*0.5));
                float3 node_4009 = MainColor;
                float3 node_5298 = lerp((node_5298_if_leA*node_8949)+(node_5298_if_leB*node_4009),node_4009,node_5298_if_leA*node_5298_if_leB);
                float4 LightColor = float4(0.93,0.93,0.93,0.95);
                float3 FinalDiffuse = (lerp((node_3337_if_leA*lerp((node_6017_if_leA*(MainColor*_SecondShadowMultColor.rgb))+(node_6017_if_leB*node_8949),node_8949,node_6017_if_leA*node_6017_if_leB))+(node_3337_if_leB*node_5298),node_5298,node_3337_if_leA*node_3337_if_leB)*LightColor.rgb);
                float SpecMask = node_5899.b;
                float node_7785_if_leA = step(1.0,(exp2((log2(saturate(normalize(halfDirection)))*10.0))+SpecMask));
                float node_7785_if_leB = step((exp2((log2(saturate(normalize(halfDirection)))*10.0))+SpecMask),1.0);
                float node_6199 = 0.0;
                float SpecStrength = node_5899.r;
                float3 FinalSpec = (LightColor.rgb*lerp((node_7785_if_leA*node_6199)+(node_7785_if_leB*(SpecStrength*0.2*1.0)),node_6199,node_7785_if_leA*node_7785_if_leB));
                float3 node_7713 = (FinalDiffuse+FinalSpec); // FinalColor
                float MainAlpha = node_8072.a;
                float3 finalColor = (((MainColor-node_7713)*MainAlpha)+node_7713);
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _LightMap; uniform float4 _LightMap_ST;
            uniform float4 _FirstShadowMultColor;
            uniform float4 _SecondShadowMultColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float4 node_8072 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 MainColor = node_8072.rgb;
                float4 node_5899 = tex2D(_LightMap,TRANSFORM_TEX(i.uv0, _LightMap)); // SpecularPower ShadowMask SpecularMask
                float ShadowMask = node_5899.g;
                float ShadowMask_x_VertexColor = (ShadowMask*i.vertexColor.r);
                float node_3337_if_leA = step(ShadowMask_x_VertexColor,0.09);
                float node_3337_if_leB = step(0.09,ShadowMask_x_VertexColor);
                float node_1720 = 0.5*dot(normalize(i.normalDir),normalize(lightDirection))+0.5;
                float SecondShaodwArea = 0.51;
                float node_6017_if_leA = step(((ShadowMask_x_VertexColor+node_1720)*0.5),SecondShaodwArea);
                float node_6017_if_leB = step(SecondShaodwArea,((ShadowMask_x_VertexColor+node_1720)*0.5));
                float3 node_8949 = (MainColor*_FirstShadowMultColor.rgb);
                float node_7353_if_leA = step(ShadowMask_x_VertexColor,0.5);
                float node_7353_if_leB = step(0.5,ShadowMask_x_VertexColor);
                float node_1663 = ((ShadowMask_x_VertexColor*1.25)-0.125);
                float FirstShadowArea = 0.51;
                float node_5298_if_leA = step(((lerp((node_7353_if_leA*node_1663)+(node_7353_if_leB*((1.2*ShadowMask_x_VertexColor)-0.1)),node_1663,node_7353_if_leA*node_7353_if_leB)+node_1720)*0.5),FirstShadowArea);
                float node_5298_if_leB = step(FirstShadowArea,((lerp((node_7353_if_leA*node_1663)+(node_7353_if_leB*((1.2*ShadowMask_x_VertexColor)-0.1)),node_1663,node_7353_if_leA*node_7353_if_leB)+node_1720)*0.5));
                float3 node_4009 = MainColor;
                float3 node_5298 = lerp((node_5298_if_leA*node_8949)+(node_5298_if_leB*node_4009),node_4009,node_5298_if_leA*node_5298_if_leB);
                float4 LightColor = float4(0.93,0.93,0.93,0.95);
                float3 FinalDiffuse = (lerp((node_3337_if_leA*lerp((node_6017_if_leA*(MainColor*_SecondShadowMultColor.rgb))+(node_6017_if_leB*node_8949),node_8949,node_6017_if_leA*node_6017_if_leB))+(node_3337_if_leB*node_5298),node_5298,node_3337_if_leA*node_3337_if_leB)*LightColor.rgb);
                float SpecMask = node_5899.b;
                float node_7785_if_leA = step(1.0,(exp2((log2(saturate(normalize(halfDirection)))*10.0))+SpecMask));
                float node_7785_if_leB = step((exp2((log2(saturate(normalize(halfDirection)))*10.0))+SpecMask),1.0);
                float node_6199 = 0.0;
                float SpecStrength = node_5899.r;
                float3 FinalSpec = (LightColor.rgb*lerp((node_7785_if_leA*node_6199)+(node_7785_if_leB*(SpecStrength*0.2*1.0)),node_6199,node_7785_if_leA*node_7785_if_leB));
                float3 node_7713 = (FinalDiffuse+FinalSpec); // FinalColor
                float MainAlpha = node_8072.a;
                float3 finalColor = (((MainColor-node_7713)*MainAlpha)+node_7713);
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
