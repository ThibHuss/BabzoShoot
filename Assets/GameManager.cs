using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{


    [SerializeField] public Color eColor;
    [SerializeField] public Color nColor;
    [SerializeField] public Color bColor;
    [SerializeField] public Color ccColor;


    [SerializeField] public Dictionary<(ElementType, ElementType), DamageModifier> damageModifiers = new Dictionary<(ElementType, ElementType), DamageModifier>
{
    {(ElementType.Fire, ElementType.Plant), new DamageModifier(1.5f, 'E')},
    {(ElementType.Fire, ElementType.Water), new DamageModifier(0.75f, 'B')},
    {(ElementType.Fire, ElementType.Fire), new DamageModifier(1f, 'N')},
    {(ElementType.Plant, ElementType.Water), new DamageModifier(1.5f, 'E')},
    {(ElementType.Plant, ElementType.Fire), new DamageModifier(0.75f, 'B')},
    {(ElementType.Plant, ElementType.Plant), new DamageModifier(1f, 'N')},
    {(ElementType.Water, ElementType.Fire), new DamageModifier(1.5f, 'E')},
    {(ElementType.Water, ElementType.Plant), new DamageModifier(0.75f, 'B')},
    {(ElementType.Water, ElementType.Water), new DamageModifier(1f, 'N')},
    {(ElementType.Light, ElementType.Plant), new DamageModifier(1f, 'N')},
    {(ElementType.Light, ElementType.Fire), new DamageModifier(1f, 'N')},
    {(ElementType.Light, ElementType.Water), new DamageModifier(1f, 'N')},
    {(ElementType.Light, ElementType.Dark), new DamageModifier(1f, 'N')},
    {(ElementType.Dark, ElementType.Plant), new DamageModifier(1f, 'N')},
    {(ElementType.Dark, ElementType.Fire), new DamageModifier(1f, 'N')},
    {(ElementType.Dark, ElementType.Water), new DamageModifier(1f, 'N')},
    {(ElementType.Dark, ElementType.Light), new DamageModifier(1f, 'N')},
};
}
