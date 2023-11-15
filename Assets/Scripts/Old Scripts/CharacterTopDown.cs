using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterTopDown : MonoBehaviour
{
    public GameObject playerModel;
    public Animator animator;

    private float currentSpeed = 5f;
    public float runSpeed = 5f;
    public float sprintSpeed = 10f;
    public bool isSprinting = false;
    private string speedXParameter = "SpeedX";
    private string speedZParameter = "SpeedZ";
    private string speedParameter = "Speed";


    private void Start()
    {
        
    }
    void Update()
    {
        MovePlayer();

        if (Input.GetMouseButtonDown(0))
        {
            Attack();
        }

        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            isSprinting = true;
            currentSpeed = sprintSpeed;
        }
        if (Input.GetKeyUp(KeyCode.LeftShift))
        {
            isSprinting = false;
            currentSpeed = runSpeed;
        }
    }

    public void EndAttack()
    {
        animator.SetBool("Attack", false);

        currentSpeed = runSpeed;
    }


    void Attack()
    {
        if(animator.GetBool("Attack") != true)
        {
            animator.SetTrigger("Attack");
            currentSpeed = runSpeed * .5f;

        }
    }
    void MovePlayer()
    {
        // Gérer le mouvement du personnage par rapport au monde.
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(horizontalInput, 0f, verticalInput).normalized * currentSpeed * Time.deltaTime;

        // Gérer la rotation du personnage en direction du curseur de la souris (uniquement sur l'axe Y).
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        Plane groundPlane = new Plane(Vector3.up, Vector3.zero);
        float rayDistance;

        // Activer le paramètre "IsMoving" de l'animator si le personnage bouge.
        if (movement.magnitude > 0f)
        {
            animator.SetBool("IsMoving", true);
        }
        else
        {
            animator.SetBool("IsMoving", false);
        }

        if (groundPlane.Raycast(ray, out rayDistance))
        {
            Vector3 pointToLook = ray.GetPoint(rayDistance);
            Vector3 lookDirection = pointToLook - playerModel.transform.position;
            lookDirection.y = 0f; // Ignorez les changements sur l'axe Y
            playerModel.transform.rotation = Quaternion.LookRotation(lookDirection);

            // Calculez la direction du mouvement par rapport à la rotation du joueur en utilisant le produit scalaire (dot product).
            Vector3 playerForward = playerModel.transform.forward.normalized;
            Vector3 playerRight = playerModel.transform.right.normalized;

            float dotForward = Vector3.Dot(movement.normalized, playerForward);
            float dotRight = Vector3.Dot(movement.normalized, playerRight);

            // Calculez les directions de course (SpeedX et SpeedZ) en fonction des dot products.
            float speedX = dotRight; // Mouvement latéral (gauche/droite)
            float speedZ = dotForward; // Mouvement avant/arrière

            // Définissez les paramètres du Blend Tree.
            animator.SetFloat(speedXParameter, speedX);
            animator.SetFloat(speedZParameter, speedZ);
            animator.SetFloat(speedParameter, movement.magnitude * 30);
        }


        // Déplacez le joueur.
        transform.Translate(movement, Space.World);
    }

}
