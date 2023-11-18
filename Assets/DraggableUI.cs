using UnityEngine;
using UnityEngine.EventSystems;

public class DraggableUI : MonoBehaviour, IDragHandler, IBeginDragHandler, IEndDragHandler
{
    private Vector2 offset;
    private RectTransform rectTransform;

    private void Awake()
    {
        rectTransform = GetComponent<RectTransform>();
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, eventData.position, eventData.pressEventCamera, out Vector2 localPointerPosition);
        offset = rectTransform.anchoredPosition - localPointerPosition;
    }

    public void OnDrag(PointerEventData eventData)
    {
        if (RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform.parent as RectTransform, eventData.position, eventData.pressEventCamera, out Vector2 localPointerPosition))
        {
            rectTransform.anchoredPosition = localPointerPosition + offset;
        }
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        // Optionnel : logique de fin de glissement
    }
}
