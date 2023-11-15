using UnityEngine;

public class LookAtCamera : MonoBehaviour
{
    private Camera mainCamera;

    void Start()
    {
        // Trouver et assigner la caméra principale
        mainCamera = Camera.main;
    }

    void Update()
    {
        // S'assurer que la caméra principale est bien définie
        if (mainCamera != null)
        {
            // Aligner le Canvas avec la rotation de la caméra
            transform.rotation = mainCamera.transform.rotation;
        }
    }
}