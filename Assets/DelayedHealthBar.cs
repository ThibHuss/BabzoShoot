using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class DelayedHealthBar : MonoBehaviour
{
    public Slider mainHealthBar; // R�f�rence au slider principal de la sant�
    private Slider delayedHealthBar; // Slider de ce script

    public float delaySpeed = 0.5f; // Vitesse de la mise � jour de la barre de sant� retard�e
    public float delayBeforeStart = .5f; // D�lai avant que la mise � jour retard�e ne commence

    private Coroutine updateCoroutine;

    private void Awake()
    {
        delayedHealthBar = GetComponent<Slider>();
    }

    private void Update()
    {
        // Commence la mise � jour de la barre de sant� retard�e si n�cessaire
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
