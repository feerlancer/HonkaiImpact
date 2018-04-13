using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HonkaiPostEffect : PostEffectBase {

    private Texture rt6;
    public Material mat118;
    private Material mat94;
    private Material mat65;
    private Material mat66;
    private Material mat67;
    private Material mat68;
    private Material mat238;
    private Material mat1108;
    public void Awake()
    {
        mat118 = GenerateMaterial(Shader.Find("Hidden/118")); 
        mat94 = GenerateMaterial(Shader.Find("Hidden/94"));
        mat65 = GenerateMaterial(Shader.Find("Hidden/65"));
        mat66 = GenerateMaterial(Shader.Find("Hidden/66"));
        mat67 = GenerateMaterial(Shader.Find("Hidden/67"));
        mat68 = GenerateMaterial(Shader.Find("Hidden/68"));
        mat238 = GenerateMaterial(Shader.Find("Hidden/238"));
        mat1108 = GenerateMaterial(Shader.Find("Hidden/1108"));
        rt6 = Resources.Load("DistortionTex") as Texture;
        Debug.Assert(mat118);
    }
    private void OnRenderImage(RenderTexture src,RenderTexture dest)
    {
        mat118 = GenerateMaterial(Shader.Find("Hidden/118"));
        mat94 = GenerateMaterial(Shader.Find("Hidden/94"));
        mat65 = GenerateMaterial(Shader.Find("Hidden/65"));
        mat66 = GenerateMaterial(Shader.Find("Hidden/66"));
        mat67 = GenerateMaterial(Shader.Find("Hidden/67"));
        mat68 = GenerateMaterial(Shader.Find("Hidden/68"));
        mat238 = GenerateMaterial(Shader.Find("Hidden/238"));
        mat1108 = GenerateMaterial(Shader.Find("Hidden/1108"));
        //create RTs
        RenderTexture rt1937 = RenderTexture.GetTemporary(src.width >> 2, src.height >> 2, 0, src.format);
        RenderTexture rt1938 = RenderTexture.GetTemporary(src.width >> 2, src.height >> 2, 0, src.format);

        int SquareSize = 256;
        RenderTexture rt1939 = RenderTexture.GetTemporary(SquareSize, SquareSize, 0, src.format);
        RenderTexture rt1940 = RenderTexture.GetTemporary(SquareSize, SquareSize, 0, src.format);
        RenderTexture rt1941 = RenderTexture.GetTemporary(SquareSize, SquareSize, 0, src.format);

        RenderTexture rt1942 = RenderTexture.GetTemporary(SquareSize/2, SquareSize/2, 0, src.format);
        RenderTexture rt1943 = RenderTexture.GetTemporary(SquareSize/2, SquareSize/2, 0, src.format);
        RenderTexture rt1944 = RenderTexture.GetTemporary(SquareSize/2, SquareSize/2, 0, src.format);

        RenderTexture rt1945 = RenderTexture.GetTemporary(SquareSize/4, SquareSize/4, 0, src.format);
        RenderTexture rt1946 = RenderTexture.GetTemporary(SquareSize/4, SquareSize/4, 0, src.format);
        RenderTexture rt1947 = RenderTexture.GetTemporary(SquareSize/4, SquareSize/4, 0, src.format);

        RenderTexture rt1948 = RenderTexture.GetTemporary(SquareSize/8, SquareSize/8, 0, src.format);
        RenderTexture rt1949 = RenderTexture.GetTemporary(SquareSize/8, SquareSize/8, 0, src.format);
        RenderTexture rt1950 = RenderTexture.GetTemporary(SquareSize/8, SquareSize/8, 0, src.format);

        RenderTexture rt1951 = RenderTexture.GetTemporary(SquareSize, SquareSize, 0, src.format);

        RenderTexture[] RtList = { rt1937, rt1938, rt1939, rt1940, rt1941, rt1942, rt1943, rt1944, rt1945, rt1946, rt1947, rt1948, rt1949, rt1950, rt1951 };
        //#62
        mat118.SetVector("_texelSize", new Vector2(1.0f / src.width, 1.0f / src.height));
        Graphics.Blit(src, rt1937, mat118);


        //#63
        mat118.SetVector("_texelSize", new Vector2(1.0f / rt1937.width, 1.0f / rt1937.height));//TODO where is 640 x360 from?
        Graphics.Blit(rt1937, rt1939, mat118);


        //#65
        mat94.SetFloat("_Scaler", 1.06f);
        mat94.SetFloat("_Threshhold", 0.65f);
        Graphics.Blit(rt1939, rt1940,mat94);


        //#67
        mat65.SetVector("_scaler", new Vector2(0.5625f, 0));
        Graphics.Blit(rt1940, rt1941, mat65);


        //#69
        mat65.SetVector("_scaler", new Vector2(0, 1));
        Graphics.Blit(rt1941, rt1939, mat65);

        //#71
        Graphics.Blit(rt1940, rt1942);



        //#73
        mat66.SetVector("_scaler", new Vector2(0.5625f, 0));
        Graphics.Blit(rt1942, rt1943,mat66);


        //#75
        mat66.SetVector("_scaler", new Vector2(0, 1));
        Graphics.Blit(rt1943, rt1944, mat66);


        //#77
        Graphics.Blit(rt1942, rt1945);

        //#78
        mat67.SetVector("_scaler", new Vector2(0.5625f, 0));
        Graphics.Blit(rt1945, rt1946, mat67);


        //#80
        mat67.SetVector("_scaler", new Vector2(0, 1));
        Graphics.Blit(rt1946, rt1947, mat67);


        //#82
        Graphics.Blit(rt1945, rt1948);

        //#84
        mat68.SetVector("_scaler", new Vector2(0.5625f, 0));
        Graphics.Blit(rt1948, rt1949, mat68);


        //#86
        mat68.SetVector("_scaler", new Vector2(0, 1));
        Graphics.Blit(rt1949, rt1950, mat68);

        //#88
        mat238.SetVector("coeff", new Vector4(0.24f, 0.24f, 0.28f, 0.225f));
        mat238.SetTexture("_MainTex0", rt1939);
        mat238.SetTexture("_MainTex1", rt1944);
        mat238.SetTexture("_MainTex2", rt1947);
        mat238.SetTexture("_MainTex3", rt1950);
        Graphics.Blit(rt1939, rt1951, mat238);


        //#90
        mat1108.SetVector("_MainTex_TexelSize",new Vector2(1.0f / src.width, 1.0f / src.height));
        mat1108.SetVector("coeff", new Vector3(0.25f, 0.75f, 0));
        mat1108.SetFloat("exposure", 13f);
        mat1108.SetFloat("constrast", 2.1f);
        mat1108.SetFloat("_EdgeThresholdMin", 0.215f);
        mat1108.SetFloat("_EdgeThreshold", 0.25f);
        mat1108.SetFloat("_EdgeSharpness", 4f);
        //TODO
        mat1108.SetVector("ttunity_ColorSpaceLuminance", new Vector4(0.22f,0.707f,0.071f,0f));
        mat1108.SetTexture("_DistortionTex", rt6);
        mat1108.SetTexture("_MainTex0", src);
        mat1108.SetTexture("_MainTex1", rt1951);

        Graphics.Blit(src, dest, mat1108) ;


        //destroy RTs
        foreach (RenderTexture r in RtList)
        {
            RenderTexture.ReleaseTemporary(r);
        }
    }
}
