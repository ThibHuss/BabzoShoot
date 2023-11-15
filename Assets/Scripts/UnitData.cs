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

    public int maxHP;
    private int currentHP;
    public float moveSpeed;
    public int attackPower;
    public float attackRange;
    public float attackSpeed;
    public float critChance;
    public float critMultiplier = 1.5f;

    public int xp = 0;
    public int xpToNextLevel;
    public int level;

    public int armor;

    public int weight;
    public int height;



    void OnEnable()
    {
        currentHP = maxHP; // Initialiser currentHP � maxHP quand l'objet est activ�
    }


    // Ajoute ici d'autres m�thodes pour g�rer les statistiques, comme la gu�rison ou l'attaque
}
