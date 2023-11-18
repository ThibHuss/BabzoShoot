using Ara;
using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileBehaviour : MonoBehaviour
{
    // Start is called before the first frame update
    public float speed; // Vitesse du projectile
    public bool isHoming; // Si le projectile est téléguidé
    public bool isPiercing = false;
    public GameObject detach;
    public Transform target; // Cible du projectile
    public UnitBehaviour casterUnit;
    public Unit targetUnit;
    public string opponentTag;
    public bool isMoving = false;

    private void Start()
    {
        
    }
    private void Update()
    {
        if (isHoming && target != null)
        {
            Vector3 direction = (target.position - transform.position).normalized;
            transform.forward = Vector3.Lerp(transform.forward, direction, Time.deltaTime * speed);
        }

        if(isMoving)
        transform.position += transform.forward * speed * Time.deltaTime;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag(opponentTag))
        {
            UnitBehaviour unitBehaviour = other.gameObject.GetComponent<UnitBehaviour>();
            if (unitBehaviour != null)
            {
                casterUnit.ApplyDamageRanged(other.GetComponent<Unit>());
            }

            if (!isPiercing)
            {
                if(detach != null)
                    detach.transform.SetParent(null);
            }
            Destroy(gameObject);
        }
    }
}
