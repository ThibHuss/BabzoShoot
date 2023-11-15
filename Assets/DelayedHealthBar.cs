using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class DelayedHealthBar : MonoBehaviour
{
    public Slider mainHealthBar; // Référence au slider principal de la santé
    private Slider delayedHealthBar; // Slider de ce script

    public float delaySpeed = 0.5f; // Vitesse de la mise à jour de la barre de santé retardée
    public float delayBeforeStart = .5f; // Délai avant que la mise à jour retardée ne commence

    private Coroutine updateCoroutine;

    private void Awake()
    {
        delayedHealthBar = GetComponent<Slider>();
    }

    private void Update()
    {
        // Commence la mise à jour de la barre de santé retardée si nécessaire
        if (delayedHealthBar.value > mainHealthBar.value)
        {
            if (updateCoroutine == null)
            {
                updateCoroutine = StartCoroutine(DelayedUpdate());
            }
        }
    }

    private IEnumerator DelayedUpdate()
    {
        yield return new WaitForSeconds(delayBeforeStart);

        while (delayedHealthBar.value > mainHealthBar.value)
        {
            delayedHealthBar.value = Mathf.Max( mainHealthBar.value, delayedHealthBar.value - delaySpeed * Time.deltaTime);
            yield return null;
        }

        updateCoroutine = null;
    }
}
