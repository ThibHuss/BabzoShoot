using Sirenix.OdinInspector;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public enum UnitType
{
    Ally,
    Enemy
}

public struct DamageModifier
{
    public float Multiplier;
    public char Efficiency; // 'E' pour efficace, 'N' pour neutre, 'B' pour basse efficacité

    public DamageModifier(float multiplier, char efficiency)
    {
        Multiplier = multiplier;
        Efficiency = efficiency;
    }
}

public class Unit : MonoBehaviour
{

    public UnitType type;
    [SerializeField, ReadOnly] private ElementType elementType;

    [SerializeField] public UnitData unitStats;
    [SerializeField] private GameObject unitUIPrefab; // Référence au prefab de l'UI
    private UnitUI unitUIInstance;


    [SerializeField] public GameObject playerModel;
    private Transform originalPos;
    public string unitName;

    [FoldoutGroup("HP")] public int maxHP;
    [FoldoutGroup("HP")] public int currentHP;

    [FoldoutGroup("XP")] public int xp;
    [FoldoutGroup("XP")] public int currentXP;
    [FoldoutGroup("XP")] public int level = 1;
    [FoldoutGroup("XP")] public int xpToNextLevel;
    [FoldoutGroup("XP")] public int experience = 0;

    [FoldoutGroup("MANA")] public int currentMana;
    [FoldoutGroup("MANA")] public int maxMana;
    [FoldoutGroup("MANA")] public int manaPerhit;


    [FoldoutGroup("ATK")] public int attackPower;
    [FoldoutGroup("ATK")] public float attackRange;
    [FoldoutGroup("ATK")] public float attackSpeed;
    [FoldoutGroup("ATK")] public float critChance;


    [FoldoutGroup("DEF")] public int armor;


    [FoldoutGroup("SPD")] public float moveSpeed;


    [FoldoutGroup("OTHER")] public int weight;
    [FoldoutGroup("OTHER")] public float height = 1f;
        

    [Header("UI")]
    [FoldoutGroup("UI")] public Slider lifeBar;
    [FoldoutGroup("UI")] public Image lifeBarImage;
    [FoldoutGroup("UI")] public Color alyLifeBarColor;
    [FoldoutGroup("UI")] public Color nmeLifeBarColor;

    [FoldoutGroup("UI")] public Slider manaBar;

    [SerializeField] public float damageEffectiveMult = 1.5f;
    [SerializeField] public float damageNeutralMult = 1f;
    [SerializeField] public float damageBadMult = .75f;


    private void Awake()
    {
        InitializeUnitUI();
    }
    void Start()
    {
        if (unitStats != null)
        {
            //Définir le tag en Ally ou Enemy
            gameObject.tag = type.ToString();

            InitializeLocalStats();
            InitializeUI();
        }

        originalPos = this.transform;
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(1)) // Clic droit
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit))
            {
                if (hit.transform == transform)
                {
                    OpenUnitUI();
                }
            }
        }
        if (unitUIInstance != null)
        {
            if (unitUIInstance.isOpened)
                UpdateUnitUI();
        }
    }

    #region UI
    private void InitializeUnitUI()
    {
        if (unitUIInstance == null)
        {
            GameObject uiGameObject = Instantiate(unitUIPrefab);
            unitUIInstance = uiGameObject.GetComponent<UnitUI>(); // Assurez-vous que le prefab a un composant UnitUI

            Canvas canvas = GameObject.FindGameObjectWithTag("Canvas").GetComponent<Canvas>();
            if (canvas != null)
            {
                uiGameObject.transform.SetParent(canvas.transform, false);
                uiGameObject.transform.localScale = Vector3.one;
                unitUIInstance.CloseUI();
            }
        }
    }
    private void OpenUnitUI()
    {
        PositionUIAtCursor();
        // Activer l'UI (qu'elle soit nouvellement créée ou déjà existante)
        unitUIInstance.gameObject.SetActive(true);
        unitUIInstance.isOpened = true;
        //UpdateUnitUI();
    }

    private void PositionUIAtCursor()
    {
        Canvas canvas = FindObjectOfType<Canvas>();
        if (canvas != null)
        {
            Vector2 screenPosition = Input.mousePosition;

            // Convertir la position de l'écran en position locale du canvas
            RectTransformUtility.ScreenPointToLocalPointInRectangle(
                canvas.GetComponent<RectTransform>(),
                screenPosition,
                canvas.worldCamera,
                out Vector2 localPosition);

            // Définir la position de l'instance de l'UI
            unitUIInstance.transform.localPosition = localPosition;
        }
    }

    private void UpdateUnitUI()
    {
        unitUIInstance.nameText.text = unitName.ToString();
        unitUIInstance.atqText.text = attackPower.ToString();
        unitUIInstance.atqSpdText.text = attackSpeed.ToString();
        unitUIInstance.crtText.text = critChance.ToString();
        unitUIInstance.spdText.text = moveSpeed.ToString();
        unitUIInstance.hpText.text = currentHP.ToString() + "/" + maxHP.ToString();
        unitUIInstance.LevelText.text = level.ToString();
    }

    #endregion
    public void InitializeLocalStats()
    {
        if (unitStats != null)
        {
            unitName = unitStats.unitName;
            maxHP = unitStats.maxHP;
            currentHP = unitStats.maxHP;

            moveSpeed = unitStats.moveSpeed;

            attackPower = unitStats.attackPower;
            attackRange = unitStats.attackRange;
            attackSpeed = unitStats.attackSpeed;
            critChance = unitStats.critChance;

            currentMana = unitStats.currentMana;
            maxMana = unitStats.maxMana;
            manaPerhit = unitStats.manaPerHit;

            armor = unitStats.armor;

            elementType = unitStats.elementType;
            
            level = unitStats.level;
            xpToNextLevel = unitStats.xpToNextLevel;

            weight = unitStats.weight;
            height = unitStats.height;
        }
    }

    
    public void InitializeUI()
    {
        //Définir la couleur de la lifebar
        if (type.ToString() == "Ally")
        {
            lifeBarImage.color = alyLifeBarColor;
        }
        else
        {
            lifeBarImage.color = nmeLifeBarColor;
        }
    }


    public void AddExperience(int exp)
    {
        experience += exp;
        CheckLevelUp();
    }
    public void AddMana()
    {
        currentMana += manaPerhit;
    }
    

    
    public void CheckLevelUp()
    {
        // if (experience >= threshold)
        // {
        //     level++;
        //     UpdateStatsForLevel();
        // }
    }
    public int ReceiveDamage(int damage)
    {
        int damageAfterArmor = Mathf.Max(0, damage - armor);
        currentHP -= damageAfterArmor;

        lifeBar.value = (float)currentHP / maxHP;

        if (currentHP <= 0)
        {
            Destroy(gameObject);
        }

        return damageAfterArmor;
    }

}
