using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlanarReflection : MonoBehaviour
{
    [SerializeField] private Camera ReflectionCamera;
    [SerializeField] private RenderTexture ReflectionRenderTexture;
    void Start()
    {
        
    }

    // Update is called once per frame
    void LateUpdate()
    {
        ReflectionCamera.transform.position = new Vector3(Camera.main.transform.position.x, -Camera.main.transform.position.y + transform.position.y, Camera.main.transform.position.z);
        ReflectionCamera.transform.rotation = Quaternion.Euler(-Camera.main.transform.eulerAngles.x, Camera.main.transform.eulerAngles.y, 0f);
    }
}
