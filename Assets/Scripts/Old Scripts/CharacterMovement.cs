using Sirenix.OdinInspector;
using System.Collections;
using UnityEngine;

public class CharacterMovement : MonoBehaviour
{
    public float moveSpeed = 5f;
    public Transform characterTransform; // Assigner le transform du personnage

    [SerializeField, ReadOnly] private string currentHexagon = ""; // Variable pour stocker le nom de la case actuelle

    private void Start()
    {
        if (characterTransform == null)
            characterTransform = transform;
    }

    [Button("Move")]
    public void MoveToHexagon(string hexagonName)
    {
        GameObject targetHexagon = GameObject.Find(hexagonName);
        if (targetHexagon != null)
        {
            StartCoroutine(MoveToTarget(targetHexagon.transform.position, hexagonName));
        }
    }

    IEnumerator MoveToTarget(Vector3 target, string targetName)
    {
        while (Vector3.Distance(characterTransform.position, target) > 0.05f)
        {
            characterTransform.position = Vector3.MoveTowards(characterTransform.position, target, moveSpeed * Time.deltaTime);
            yield return null;
        }

        currentHexagon = targetName; // Mise à jour de la case actuelle
    }

    public string GetCurrentHexagon()
    {
        return currentHexagon;
    }
}
