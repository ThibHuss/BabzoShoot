using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class UnitUI : MonoBehaviour
{
    [SerializeField] public TextMeshProUGUI nameText;
    [SerializeField] public TextMeshProUGUI atqText;
    [SerializeField] public TextMeshProUGUI atqSpdText;
    [SerializeField] public TextMeshProUGUI crtText;
    [SerializeField] public TextMeshProUGUI defText;
    [SerializeField] public TextMeshProUGUI spdText;
    [SerializeField] public TextMeshProUGUI LevelText;
    [SerializeField] public TextMeshProUGUI hpText;

    public bool isOpened = false;

    // Start is called before the first frame update
    public void CloseUI()
    {
        isOpened = false;
        gameObject.SetActive(false);
    }
}
