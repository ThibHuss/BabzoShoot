using UnityEngine;

public class DestroyAfterDelay : MonoBehaviour
{
    public float delay = 5.0f; // Dur�e avant la destruction, en secondes. Vous pouvez le r�gler dans l'inspecteur Unity.

    void Start()
    {
        Destroy(gameObject, delay); // D�truit l'objet apr�s le d�lai sp�cifi�.
    }
}