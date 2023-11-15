using UnityEngine;

public class DestroyAfterDelay : MonoBehaviour
{
    public float delay = 5.0f; // Durée avant la destruction, en secondes. Vous pouvez le régler dans l'inspecteur Unity.

    void Start()
    {
        Destroy(gameObject, delay); // Détruit l'objet après le délai spécifié.
    }
}