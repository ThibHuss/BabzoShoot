using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Hit Effect", menuName = "Hit effect")]

public class HitEffect : ScriptableObject
{
    [SerializeField] public string[] parameterName;
    [SerializeField] public AnimationCurve[] animCurve;
    [SerializeField] public float[] duration;
}