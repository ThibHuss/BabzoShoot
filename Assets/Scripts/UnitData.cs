using Sirenix.OdinInspector;
using System.Collections.Generic;
using UnityEngine;

// D�finition de l'�num�ration pour le type d'unit�
public enum ElementType
{
    Fire,
    Water,
    Plant,
    Light,
    Dark
}

public enum UnitStyle
{
    Melee,
    Ranged,
    Assassin
}

public enum UnitRank
{
    oneStar,
    twoStar,
    threeStar,
    fourStar,
    fiveStar
}

[CreateAssetMenu(fileName = "New Unit", menuName = "Unit")]

public class UnitData : ScriptableObject
{
    public string unitName;

    public ElementType elementType;
    public UnitStyle unitStyle;

    [FoldoutGroup("HP")] public int maxHP;
    [FoldoutGroup("HP")] private int currentHP;
    
    [FoldoutGroup("ATK")] public int attackPower;
    [FoldoutGroup("ATK")] public float attackRange;
    [FoldoutGroup("ATK")] public float attackSpeed;
    [FoldoutGroup("ATK")] public float critChance;
    [FoldoutGroup("ATK")] public float critMultiplier = 1.5f;

    [FoldoutGroup("MANA")] public int currentMana = 0;
    [FoldoutGroup("MANA")] public int maxMana = 100;
    [FoldoutGroup("MANA")] public int manaPerHit = 10;

    [FoldoutGroup("XP")] public int xp = 0;
    [FoldoutGroup("XP")] public int xpToNextLevel = 100;
    [FoldoutGroup("XP")] public int level = 1;
    [FoldoutGroup("XP")] public int xpGiven = 10;

    [FoldoutGroup("DEF")] public int armor;

    [FoldoutGroup("SPD")] public float moveSpeed;

    [FoldoutGroup("OTHER")] public int weight;
    [FoldoutGroup("OTHER")] public int height;



    void OnEnable()
    {
        currentHP = maxHP; // Initialiser currentHP � maxHP quand l'objet est activ�
    }

    public void AddExperience(int exp)
    {
        xp += exp;
        CheckLevelUp();
    }

    private void CheckLevelUp()
    {
        while (xp >= xpToNextLevel)
        {
            LevelUp();
        }
    }

    private void LevelUp()
    {
        level++;
        xp -= xpToNextLevel;
        xpToNextLevel = CalculateXpForNextLevel(level); // M�thode pour calculer l'XP n�cessaire
        xpGiven = CalculateXpGiven(level);
        UpdateStatsForLevel(); // M�thode pour mettre � jour les stats
    }

    private int CalculateXpForNextLevel(int level)
    {
        return 100 * level;
    }

    private int CalculateXpGiven(int xpGiven)
    {
        return 10 * level;
    }

    private void UpdateStatsForLevel()
    {
        // Mettez � jour les statistiques ici, par exemple, augmenter maxHP, attackPower, etc.
    }
    // Ajoute ici d'autres m�thodes pour g�rer les statistiques, comme la gu�rison ou l'attaque
}
