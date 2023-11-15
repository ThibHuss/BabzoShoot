using UnityEngine;
using Cinemachine;
using Sirenix.OdinInspector;
using System.Collections;

namespace Animation
{
    /// <summary>
    /// The animation object.
    /// </summary>
    public class AnimationObject : MonoBehaviour
    {
        [SerializeField] internal float lifeTime = 3;
        [SerializeField] private bool detach = true;
        [SerializeField] private Vector3 localVelocity = Vector3.zero;

        [Header("Camera Shake")]
        [SerializeField] private bool camShake = false;
        private CinemachineVirtualCamera vCam;
        [SerializeField, ShowIf("camShake")] private float shakeIntensity;
        [SerializeField, ShowIf("camShake")] private float distanceMaxCamShake = 40;
        [SerializeField, ShowIf("camShake")] private float shakeTime = 1f;
        private float shakeTimer;

        [Header("Light Parameters")]
        [SerializeField] private bool lightAnim = false;
        [SerializeField, ShowIf("lightAnim")] private AnimationCurve lightIntensityCurve;
        [SerializeField, ShowIf("lightAnim")] private float multiplier = 1.0f; // The initial multiplier of the light
        [SerializeField, ShowIf("lightAnim")] private float animationDuration = 5.0f; // Total duration of the animation in seconds

        //[Header("Change Material")]
        //[SerializeField] private bool changeMaterial = false;
        //[SerializeField, ShowIf("changeMaterial")] private GameObject materialChanger;

        private Light[] directionalLights;
        private float[] originalIntensities;

        /// <summary>
        /// Start method.
        /// </summary>
        private void Start()
        {
            if (detach)
                transform.SetParent(null);
            if (localVelocity != Vector3.zero && GetComponent<Rigidbody>() != null)
            {
                Vector3 forward = Vector3.forward;
                var velocityToApply = new Vector3(forward.x * localVelocity.x, forward.y * localVelocity.y, forward.z * localVelocity.z);
                GetComponent<Rigidbody>().velocity = velocityToApply;
            }
            Destroy(gameObject, lifeTime);

            if (camShake)
                vCam = FindObjectOfType<CinemachineVirtualCamera>();

            if (lightAnim)
                StartCoroutine(AnimateLightIntensity());
        }

        private IEnumerator AnimateLightIntensity()
        {
            float startTime = Time.time;
            while (Time.time - startTime < animationDuration)
            {
                float normalizedTime = (Time.time - startTime) / animationDuration;
                float curveValue = lightIntensityCurve.Evaluate(normalizedTime);

                for (int i = 0; i < directionalLights.Length; i++)
                {
                    if (directionalLights[i] != null && directionalLights[i].type == LightType.Directional)
                        directionalLights[i].intensity = originalIntensities[i] * multiplier * curveValue;
                }

                yield return null;
            }

            for (int i = 0; i < directionalLights.Length; i++)
            {
                if (directionalLights[i] != null && directionalLights[i].type == LightType.Directional)
                    directionalLights[i].intensity = originalIntensities[i];
            }
        }

        private IEnumerator ShakeCameraCoroutine(float duration)
        {
            float startTime = Time.time;
            while (Time.time - startTime < duration)
            {
                float normalizedTime = (Time.time - startTime) / duration;
                ShakeCamera(shakeIntensity, duration - (Time.time - startTime));
                yield return null;
            }
            ShakeCamera(0f, 0f);
        }

        private void Update()
        {
            if (shakeTimer > 0)
                shakeTimer -= Time.deltaTime;
            else if (camShake)
            {
                StartCoroutine(ShakeCameraCoroutine(shakeTime));
                camShake = false;
            }
        }

        public void ShakeCamera(float intensity, float time)
        {
            CinemachineBasicMultiChannelPerlin perlin = vCam.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();

            if (perlin != null)
                perlin.m_AmplitudeGain = intensity * Mathf.Clamp((1 - (Vector3.Distance(transform.position, vCam.transform.position) / distanceMaxCamShake)), 0f, 1f);
            shakeTimer = time;
        }
    }
}
