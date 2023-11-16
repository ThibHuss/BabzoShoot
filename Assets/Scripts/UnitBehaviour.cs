using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.AI;
using static Unit;
using DG.Tweening;
using UnityEditor;
using Sirenix.OdinInspector;
using System.ComponentModel;

public class UnitBehaviour : MonoBehaviour
{

    private Animator animator;
    private GameManager gameManager;
    


    private NavMeshAgent agent;
    private Unit unit;
    private UnitType targetType;
    private GameObject focusedEnemy; // Variable pour stocker l'ennemi ciblé
    private bool isAttacking = false;

    [FoldoutGroup("Attack Related")] public bool isProjectile;
    [FoldoutGroup("Attack Related"), ShowIf("isProjectile")] public GameObject fxProjectile;
    [FoldoutGroup("Attack Related"), ShowIf("isProjectile")] public GameObject projectileLoc;
    [FoldoutGroup("Attack Related"), ShowIf("isProjectile")] public float projectileSpeed = 1f;
    [FoldoutGroup("Attack Related")] public GameObject attackEffectPrefab;
    [FoldoutGroup("Attack Related")] public GameObject attackTextPrefab;
    [FoldoutGroup("Attack Related")] public HitEffect hitEffect;
    private Vector3 damageTextOffset = new Vector3(0, 1, 0);
    

    void Start()
    {
        animator = GetComponent<Animator>();
        gameManager = FindAnyObjectByType<GameManager>();
        agent = GetComponent<NavMeshAgent>();
        unit = GetComponent<Unit>();

        targetType = unit.type == UnitType.Ally ? UnitType.Enemy : UnitType.Ally;

        if (unit.unitStats != null)
        {
            agent.speed = unit.unitStats.moveSpeed;
            agent.stoppingDistance = unit.unitStats.attackRange;
        }

        MaterialInstancier();
    }

    void Update()
    {
        if (focusedEnemy == null)
        {
            focusedEnemy = FindClosestEnemy();
        }

        if (focusedEnemy != null)
        {
            float distanceToEnemy = Vector3.Distance(transform.position, focusedEnemy.transform.position);

            if (distanceToEnemy > unit.unitStats.attackRange)
            {
                agent.SetDestination(focusedEnemy.transform.position);
                animator.SetBool("Moving", true);
                agent.isStopped = false;
                isAttacking = false;
            }
            else
            {
                agent.isStopped = true;
                animator.SetBool("Moving", false);
                RotateTowards(focusedEnemy.transform);

                if (!isAttacking && unit.attackSpeed != 0)
                    StartCoroutine(AttackRoutine());
            }
        }

        agent.speed *= this.unit.moveSpeed;
    }

    #region Attack
    IEnumerator AttackRoutine()
    {
        isAttacking = true;

        // Ajustement de la vitesse de l'animation en fonction de la vitesse d'attaque
        float animationSpeed = unit.unitStats.attackSpeed;
        animator.speed = animationSpeed;

        animator.SetTrigger("Attack");

        // Calculer la durée réelle de l'animation basée sur la vitesse d'animation
        float animationDuration = 1f / animationSpeed;

        // Attendez la fin de l'animation d'attaque
        yield return new WaitForSeconds(animationDuration);

        // Réinitialiser la vitesse de l'animation à sa valeur par défaut si nécessaire
        animator.speed = 1f;

        isAttacking = false;
    }
    public void ApplyDamageMonoTarget()
    {
        if (focusedEnemy != null)
        {
            Unit attackerUnit = GetComponent<Unit>(); // L'unité qui attaque
            Unit enemyUnit = focusedEnemy.GetComponent<Unit>();

            int initialDamage = attackerUnit.unitStats.attackPower;
            bool isCriticalHit = Random.Range(0f, 100f) <= attackerUnit.unitStats.critChance;

            if (isCriticalHit)
            {
                initialDamage = Mathf.RoundToInt(initialDamage * attackerUnit.unitStats.critMultiplier);
            }

            var (damageWithElementalEffect, efficiency) = CalculateDamage(attackerUnit, enemyUnit, initialDamage);

            Color textColor;
            switch (efficiency)
            {
                case 'E':
                    textColor = gameManager.eColor; // Couleur pour efficace
                    break;
                case 'B':
                    textColor = gameManager.bColor; // Couleur pour basse efficacité
                    break;
                default:
                    textColor = isCriticalHit ? gameManager.ccColor : gameManager.nColor; // Rouge pour critique, blanc pour neutre
                    break;
            }

            CreateAttackText($"{damageWithElementalEffect}", textColor, focusedEnemy.transform.position);

            if (attackEffectPrefab != null)
            {
                Instantiate(attackEffectPrefab, (focusedEnemy.transform.position + damageTextOffset), Quaternion.identity);
            }

            enemyUnit.ReceiveDamage(damageWithElementalEffect);
            StartCoroutine(AnimateMaterialParameter(enemyUnit));


            ApplyPunchToTarget(this.gameObject, enemyUnit.playerModel, damageWithElementalEffect, enemyUnit.weight);
        }
    }
    public void ApplyDamageRanged(Unit opponent)
    {
        Unit attackerUnit = GetComponent<Unit>(); // L'unité qui attaque

        if (opponent != null)
        {
            int initialDamage = attackerUnit.unitStats.attackPower;
            bool isCriticalHit = Random.Range(0f, 100f) <= attackerUnit.unitStats.critChance;

            if (isCriticalHit)
            {
                initialDamage = Mathf.RoundToInt(initialDamage * attackerUnit.unitStats.critMultiplier);
            }

            var (damageWithElementalEffect, efficiency) = CalculateDamage(attackerUnit, opponent, initialDamage);

            Color textColor;
            switch (efficiency)
            {
                case 'E':
                    textColor = gameManager.eColor; // Couleur pour efficace
                    break;
                case 'B':
                    textColor = gameManager.bColor; // Couleur pour basse efficacité
                    break;
                default:
                    textColor = isCriticalHit ? gameManager.ccColor : gameManager.nColor; // Rouge pour critique, blanc pour neutre
                    break;
            }

            CreateAttackText($"{damageWithElementalEffect}", textColor, opponent.transform.position);

            if (attackEffectPrefab != null)
            {
                Instantiate(attackEffectPrefab, (opponent.transform.position + damageTextOffset), Quaternion.identity);
            }

            opponent.ReceiveDamage(damageWithElementalEffect);
            StartCoroutine(AnimateMaterialParameter(opponent));


            ApplyPunchToTarget(this.gameObject, opponent.playerModel, damageWithElementalEffect, opponent.weight);
            }
        }

    public void FireProjectile()
    {
        if (fxProjectile == null || projectileLoc == null || focusedEnemy == null)
        {
            return;
        }

        Unit enemyUnit = focusedEnemy.GetComponent<Unit>();
        if (enemyUnit == null || enemyUnit.unitStats == null)
        {
            Debug.LogError("No Unit or UnitData found on the focused enemy.");
            return;
        }

        // Récupérer la position de l'ennemi avec un offset en Y égal à sa hauteur
        Vector3 targetPosition = focusedEnemy.transform.position + new Vector3(0, enemyUnit.height, 0);

        // Calculer la direction vers cette position ajustée
        Vector3 direction = (targetPosition - projectileLoc.transform.position).normalized;

        // Instancier le projectile avec la bonne orientation
        GameObject projectileInstance = Instantiate(fxProjectile, projectileLoc.transform.position, Quaternion.LookRotation(direction));
        ProjectileBehaviour projectileBehaviour = projectileInstance.GetComponentInChildren<ProjectileBehaviour>();
        projectileBehaviour.target = focusedEnemy.transform;
        projectileBehaviour.casterUnit = this;

        projectileBehaviour.opponentTag = targetType.ToString();
    }
    public void ApplyPunchToTarget(GameObject attacker, GameObject opponent, float damage, float weight)
    {
        // Tuer les animations en cours pour éviter les superpositions
        opponent.transform.DOKill();

        // Réinitialiser la position avant de commencer l'animation
        opponent.transform.localPosition = Vector3.zero;

        Vector3 directionToTarget = opponent.transform.position - attacker.transform.position;
        Vector3 punchDirection = -directionToTarget.normalized * Mathf.Clamp((damage / weight), 0, 1);

        opponent.transform.DOPunchPosition(punchDirection, 0.2f, 10)
            .OnStart(() => opponent.transform.localPosition = Vector3.zero)
            .OnComplete(() => opponent.transform.localPosition = Vector3.zero);
    }

    #endregion
    IEnumerator AnimateMaterialParameter(Unit opponent)
    {
        if (hitEffect == null || opponent == null) yield break;

        Renderer[] renderers = opponent.GetComponentsInChildren<Renderer>();
        float[] curveTimers = new float[hitEffect.parameterName.Length];

        while (true)
        {
            bool isAnimationComplete = true;

            for (int i = 0; i < hitEffect.parameterName.Length; i++)
            {
                if (curveTimers[i] < hitEffect.duration[i])
                {
                    isAnimationComplete = false;
                    float curveValue = hitEffect.animCurve[i].Evaluate(curveTimers[i] / hitEffect.duration[i]);
                    ApplyMaterialParameterToEnemy(renderers, hitEffect.parameterName[i], curveValue);
                    curveTimers[i] += Time.deltaTime;
                }
            }

            if (isAnimationComplete) break;

            yield return null;
        }

        // Optionnellement, réinitialiser les paramètres à leur état initial
        for (int i = 0; i < hitEffect.parameterName.Length; i++)
        {
            ApplyMaterialParameterToEnemy(renderers, hitEffect.parameterName[i], hitEffect.animCurve[i].Evaluate(0));
        }
    }

    void ApplyMaterialParameterToEnemy(Renderer[] renderers, string parameterName, float value)
    {
        foreach (Renderer renderer in renderers)
        {
            if (renderer == null)
            {
                continue;
            }

            foreach (Material material in renderer.materials)
            {
                if (material == null)
                {
                    continue;
                }

                if (material.HasProperty(parameterName))
                {
                    material.SetFloat(parameterName, value);
                }
            }
        }
    }
    public (int Damage, char Efficiency) CalculateDamage(Unit attacker, Unit defender, int baseDamage)
    {
        float typeMultiplier = 1f;
        char efficiency = 'N'; // Par défaut, neutre

        if (gameManager.damageModifiers.TryGetValue((attacker.unitStats.elementType, defender.unitStats.elementType), out DamageModifier modifier))
        {
            typeMultiplier = modifier.Multiplier;
            efficiency = modifier.Efficiency;
        }

        int damageAfterArmor = Mathf.Max(0, baseDamage - defender.unitStats.armor);
        return (Mathf.RoundToInt(damageAfterArmor * typeMultiplier), efficiency);
    }


    void CreateAttackText(string text, Color color, Vector3 position)
    {
        var attackTextInstance = Instantiate(attackTextPrefab, position, Quaternion.identity);
        var textComponent = attackTextInstance.GetComponentInChildren<TextMeshPro>();

        if (textComponent != null)
        {
            textComponent.text = text;
            textComponent.color = color;

            // Appliquer une animation différente en fonction de la couleur, indiquant un coup critique ou non
            if (color == Color.red) // Supposons que les coups critiques ont la couleur rouge
            {
                PlayCriticalAnimation(attackTextInstance);
            }
            else
            {
                PlayRegularAnimation(attackTextInstance);
            }
        }
    }

    void PlayCriticalAnimation(GameObject obj)
    {
        // Exemple d'animation pour un coup critique
        Vector3 randomDirection = GetRandomDirectionInCone(Vector3.up, 90f);
        float distance = .6f; // Distance de déplacement dans la direction randomisée

        obj.transform.DOLocalMove(obj.transform.localPosition + randomDirection * distance, .7f);
        obj.transform.DOShakeScale(.2f, .2f, 10, 90);
        //obj.transform.DOScale(1.5f, 0.3f).SetLoops(2, LoopType.Yoyo); // Animation de mise à l'échelle

    }

    void PlayRegularAnimation(GameObject obj)
    {
        // Exemple d'animation pour un coup régulier
        Vector3 randomDirection = GetRandomDirectionInCone(Vector3.up, 90f);
        float distance = .6f; // Distance de déplacement plus courte pour un coup régulier

        obj.transform.DOLocalMove(obj.transform.localPosition + randomDirection * distance, .7f);
    }

    Vector3 GetRandomDirectionInCone(Vector3 coneDirection, float coneAngle)
    {
        coneDirection.Normalize();
        float angle = Random.Range(0, coneAngle);
        float radius = Mathf.Tan(angle * Mathf.Deg2Rad);

        // Trouver un point aléatoire dans un cercle
        Vector2 randomCircle = Random.insideUnitCircle * radius;

        // Convertir en 3D en utilisant le cercle comme base
        Quaternion rotation = Quaternion.FromToRotation(Vector3.forward, coneDirection);
        Vector3 randomDirection = rotation * new Vector3(randomCircle.x, randomCircle.y, 1);

        return randomDirection.normalized;
    }


    void RotateTowards(Transform target)
    {
        Vector3 direction = (target.position - transform.position).normalized;
        if (direction != Vector3.zero)
        {
            Quaternion lookRotation = Quaternion.LookRotation(direction);
            transform.rotation = Quaternion.Slerp(transform.rotation, lookRotation, Time.deltaTime * 5f); // Ajuste le 5f si nécessaire
        }
    }

    GameObject FindClosestEnemy()
    {
        GameObject[] enemies = GameObject.FindGameObjectsWithTag(targetType.ToString());
        GameObject closest = null;
        float minDistance = Mathf.Infinity;
        Vector3 currentPosition = transform.position;

        foreach (GameObject enemy in enemies)
        {
            float distance = Vector3.Distance(enemy.transform.position, currentPosition);
            if (distance < minDistance)
            {
                closest = enemy;
                minDistance = distance;
            }
        }

        return closest;
    }

    private void MaterialInstancier()
    {
        // Trouver tous les Renderers dans ce GameObject et ses enfants
        Renderer[] renderers = GetComponentsInChildren<Renderer>();

        foreach (Renderer renderer in renderers)
        {
            Material[] instanceMaterials = new Material[renderer.materials.Length];

            for (int i = 0; i < renderer.materials.Length; i++)
            {
                // Créer une nouvelle instance du matériel
                instanceMaterials[i] = Instantiate(renderer.materials[i]);
            }

            // Appliquer les matériaux instanciés au Renderer
            renderer.materials = instanceMaterials;
        }
    }
}
