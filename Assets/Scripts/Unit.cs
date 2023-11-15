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

    [Header("Stats")]
    [SerializeField] public string unitName;
    [SerializeField] public int maxHP;
    [SerializeField] public int currentHP;
    [SerializeField] public int currentXP;
    [SerializeField] public int level = 1;
    [SerializeField] public int xpToNextLevel;
    [SerializeField] public int experience = 0;
    [SerializeField] public float moveSpeed;
    [SerializeField] public int attackPower;
    [SerializeField] public float attackRange;
    [SerializeField] public float attackSpeed;
    [SerializeField] public float critChance;
    [SerializeField] public float def;
    [SerializeField] public int weight;
    [SerializeField] public float height = 1f;

    [Header("UI")]
    [SerializeField] public Slider lifeBar;
    [SerializeField] public Image sliderImage;
    [SerializeField] public Color alyLifeBarColor;
    [SerializeField] public Color nmeLifeBarColor;

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
            Vector2 position = Input.mousePosition;
            //RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.GetComponent<RectTransform>(), position, canvas.worldCamera, out Vector2 localPoint);
            unitUIInstance.transform.localPosition = position;
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
            def = unitStats.armor;
            elementType = unitStats.elementType;
            
            level = unitStats.level;
            xpToNextLevel = unitStats.xpToNextLevel;
            level = unitStats.level;

            weight = unitStats.weight;
            height = unitStats.height;
        }
    }

    public void InitializeUI()
    {
        //Définir la couleur de la lifebar
        if (type.ToString() == "Ally")
        {
            sliderImage.color = alyLifeBarColor;
        }
        else
        {
            sliderImage.color = nmeLifeBarColor;
        }
    }


    public void AddExperience(int exp)
    {
        experience += exp;
        CheckLevelUp();
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
        int damageAfterArmor = Mathf.Max(0, damage - unitStats.armor);
        currentHP -= damageAfterArmor;

        lifeBar.value = (float)currentHP / unitStats.maxHP;

        if (currentHP <= 0)
        {
            Destroy(gameObject);
        }

        return damageAfterArmor;
    }

}
