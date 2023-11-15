using UnityEngine;

public class LookAtCamera : MonoBehaviour
{
    private Camera mainCamera;

    void Start()
    {
        // Trouver et assigner la cam�ra principale
        mainCamera = Camera.main;
    }

    void Update()
    {
        // S'assurer que la cam�ra principale est bien d�finie
        if (mainCamera != null)
        {
            // Aligner le Canvas avec la rotation de la cam�ra
            transform.rotation = mainCamera.transform.rotation;
        }
    }
}