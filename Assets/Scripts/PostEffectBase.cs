using UnityEngine;  
using System.Collections;  


[ExecuteInEditMode]  

[RequireComponent(typeof(Camera))]  

public class PostEffectBase : MonoBehaviour {  


	Shader shader = null;  
	private Material _material = null;  
	public Material _Material  
	{  
		get  
		{  
			if (_material == null)  
				_material = GenerateMaterial(shader);  
			return _material;  
		}  
	}  


	protected Material GenerateMaterial(Shader shader)  
	{
        bool ad = shader && shader.isSupported;

		Material material = new Material(shader);  
		material.hideFlags = HideFlags.DontSave;
        Debug.Assert(material);
        if (material)  
			return material;  
		return null;  
	}  

}  