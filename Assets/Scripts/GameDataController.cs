using System.Collections.Generic;
using System.IO;
using UnityEngine;

[System.Serializable]
public class GameData
{
    public List<UnitData> units;
}

public class GameDataController : MonoBehaviour
{
    private string filePath;

    void Start()
    {
        filePath = Path.Combine(Application.persistentDataPath, "gameData.json");
    }

    public void SaveGameData(List<UnitData> units)
    {
        GameData gameData = new GameData { units = units };
        string json = JsonUtility.ToJson(gameData);
        File.WriteAllText(filePath, json);
    }

    public GameData LoadGameData()
    {
        if (File.Exists(filePath))
        {
            string json = File.ReadAllText(filePath);
            return JsonUtility.FromJson<GameData>(json);
        }
        return new GameData();
    }
}
