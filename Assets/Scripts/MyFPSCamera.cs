using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyFPSCamera : MonoBehaviour {

	public enum RotationAxes { MouseXAndY = 0, MouseX = 1, MouseY = 2 }
	public RotationAxes axes = RotationAxes.MouseXAndY;
	float sensitivityX = 3F;
	float sensitivityY = 3F;
	float minimumX = -360F;
	float maximumX = 360F;
	float minimumY = -90F;
	float maximumY = 90F;
	float rotationY = 0F;
	void Update ()
	{
		float verticalDelta = 10 * Time.deltaTime;
		float leftDelta = -10 * Time.deltaTime;
		float frontDelta = 10 * Time.deltaTime;

		if (Input.GetKey (KeyCode.Space))  
		{  
			this.gameObject.transform.Translate(0,verticalDelta,0);  
		}      

		if (Input.GetKey (KeyCode.LeftShift))  
		{  
			this.gameObject.transform.Translate(0,-verticalDelta,0);  
		}      
			
		if(Input.GetKey(KeyCode.W))  
		{  
			this.gameObject.transform.Translate(new Vector3(0,0,frontDelta));  
		}  
		if(Input.GetKey(KeyCode.S))  
		{  
			this.gameObject.transform.Translate(new Vector3(0,0,-frontDelta));  
		}  
		if(Input.GetKey(KeyCode.A))  
		{  
			this.gameObject.transform.Translate(new Vector3(leftDelta,0,0));  
		}  
		if(Input.GetKey(KeyCode.D))  
		{  
			this.gameObject.transform.Translate(new Vector3(-leftDelta,0,0));  
		}  

		if (axes == RotationAxes.MouseXAndY)
		{
			float rotationX = transform.localEulerAngles.y + Input.GetAxis("Mouse X") * sensitivityX;

			rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
			rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);

			transform.localEulerAngles = new Vector3(-rotationY, rotationX, 0);
		}
		else if (axes == RotationAxes.MouseX)
		{
			transform.Rotate(0, Input.GetAxis("Mouse X") * sensitivityX, 0);
		}
		else
		{
			rotationY += Input.GetAxis("Mouse Y") * sensitivityY;
			rotationY = Mathf.Clamp (rotationY, minimumY, maximumY);

			transform.localEulerAngles = new Vector3(-rotationY, transform.localEulerAngles.y, 0);
		}
	}

	void Start ()
	{
		// Make the rigid body not change rotation
		if (GetComponent<Rigidbody>())
			GetComponent<Rigidbody>().freezeRotation = true;
	}
}
