// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Gemelli/FX_PannerAddMul"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Header(Main Texture)][Header(.)]_MainTex("MainTex", 2D) = "white" {}
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_TextureLevels("Texture Levels", Float) = 1
		_TexAlphaPower("Tex Alpha Power", Float) = 1
		_TexturePanSpeed("Texture Pan Speed", Vector) = (0,0,0,0)
		_EmissiveIntensity("EmissiveIntensity", Float) = 1
		_OpacityInt("OpacityInt", Float) = 1
		_FinalMix("FinalMix", Float) = 1
		[KeywordEnum(True,False)] _Texhasaslpha("Tex has aslpha", Float) = 0
		[Toggle(_USEGRADIENTMAP_ON)] _UseGradientMap("Use Gradient Map", Float) = 0
		_GradientMap("Gradient Map", 2D) = "white" {}
		_GradientMapValues("Gradient Map Values", Vector) = (0,0,1,1)
		[KeywordEnum(None,U,V,VCenter)] _MaskType("Mask Type", Float) = 0
		[Toggle(_INVERTMASK_ON)] _Invertmask("Invert mask", Float) = 0
		_MaskPower("Mask Power", Float) = 1
		_MaskOffset("Mask Offset", Float) = 0
		[KeywordEnum(Panner,Custom)] _PanType("PanType", Float) = 0
		[HDR]_WorldCenterColor("WorldCenter Color", Color) = (0,0,0,0)
		_CenterColorSize("Center Color Size", Float) = 0
		_CenterSmoothness("Center Smoothness", Float) = 0
		_DFDistance("DF Distance", Float) = 0
		[KeywordEnum(False,True)] _Use2SidedColor("Use 2Sided Color", Float) = 0
		_2SidedInt("2Sided Int", Float) = 1
		[Toggle(_USEDISTORT_ON)] _UseDistort("Use Distort", Float) = 0
		_DistortTex("DistortTex", 2D) = "white" {}
		_Distort("Distort", Range( 0 , 1)) = 1
		_DistortPanSpeed("Distort Pan Speed", Vector) = (0,0,0,0)
		[Toggle(_USEVERTEXOFFSET_ON)] _UseVertexOffset("UseVertexOffset", Float) = 0
		_VertexOffset("Vertex Offset", Float) = 0
		[Toggle(_USEDISTTEX_ON)] _UseDistTex("UseDistTex", Float) = 0
		_HitColor("HitColor", Color) = (1,1,1,0)
		_HitEffect("HitEffect", Range( 0 , 1)) = 0

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		//[HideInInspector] _ShadowMatteFilter("Shadow Matte Filter", Float) = 2.006836
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0 // StencilUsage.Clear
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 0 // Nothing
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8 // StencilUsage.TraceReflectionRay
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 2 // StencilUsage.DistortionVectors
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 2 // StencilUsage.DistortionVectors
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 2 // StencilUsage.RequiresDeferredLighting
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector][ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector] _SurfaceType("Surface Type", Float) = 1
		[HideInInspector] _BlendMode("Blend Mode", Float) = 4
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector][ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector][ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 0
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Float) = 0
		[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2 // This mode is dedicated to Forward to correctly handle backface then front face rendering thin transparent
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] _TransparentCullMode("Transparent Cull Mode", Int) = 2// Back culling by default
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4 // Less equal
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Int) = 4// Less equal
		[HideInInspector][ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector][ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 0
		[HideInInspector][ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 1
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)
		[HideInInspector] _DistortionEnable("_DistortionEnable",Float) = 0
		[HideInInspector] _DistortionOnly("_DistortionOnly",Float) = 0

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] _OpaqueCullMode("Opaque Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector][ToggleUI] _SupportDecals("Support Decals", Float) = 1
		[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
		[HideInInspector] _EmissionColor("Color", Color) = (1, 1, 1)
		[HideInInspector] _UnlitColorMap_MipInfo("_UnlitColorMap_MipInfo", Vector) = (0, 0, 0, 0)

		[HideInInspector][Enum(Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0 //DoubleSidedGIMode added in api 12x and higher
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Transparent" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma exclude_renderers glcore gles gles3 ps4 ps5 

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward Unlit"
			Tags { "LightMode"="ForwardOnly" }

			Blend One OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha

			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			ColorMask [_ColorMaskTransparentVel] 1

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile _ DEBUG_DISPLAY

			#pragma vertex Vert
			#pragma fragment Frag

	        #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
	        #define _WRITE_TRANSPARENT_MOTION_VECTOR
	        #endif

			#define SHADERPASS SHADERPASS_FORWARD_UNLIT
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#if defined(_ENABLE_SHADOW_MATTE) && SHADERPASS == SHADERPASS_FORWARD_UNLIT
				#define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
				#define HAS_LIGHTLOOP
				#define SHADOW_OPTIMIZE_REGISTER_USAGE 1

				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Shadow/HDShadowContext.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/HDShadow.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/PunctualLightCommon.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/HDShadowLoop.hlsl"
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _USE2SIDEDCOLOR_FALSE _USE2SIDEDCOLOR_TRUE
			#pragma shader_feature_local _USEGRADIENTMAP_ON
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;
			sampler2D _GradientMap;
			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			
			struct SurfaceDescription
			{
				float3 Color;
				float3 Emission;
				float4 ShadowTint;
				float Alpha;
				float AlphaClipThreshold;
				float4 VTPackedFeedback;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				surfaceData.color = surfaceDescription.Color;
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription , FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#if _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);

				#ifdef WRITE_NORMAL_BUFFER
				surfaceData.normalWS = fragInputs.tangentToWorld[2];
				#endif

				#if defined(_ENABLE_SHADOW_MATTE) && SHADERPASS == SHADERPASS_FORWARD_UNLIT
					HDShadowContext shadowContext = InitShadowContext();
					float shadow;
					float3 shadow3;
					posInput = GetPositionInput(fragInputs.positionSS.xy, _ScreenSize.zw, fragInputs.positionSS.z, UNITY_MATRIX_I_VP, UNITY_MATRIX_V);
					float3 normalWS = normalize(fragInputs.tangentToWorld[1]);
					uint renderingLayers = _EnableLightLayers ? asuint(unity_RenderingLayer.x) : DEFAULT_LIGHT_LAYERS;
					ShadowLoopMin(shadowContext, posInput, normalWS, asuint(_ShadowMatteFilter), renderingLayers, shadow3);
					shadow = dot(shadow3, float3(1.0f/3.0f, 1.0f/3.0f, 1.0f/3.0f));

					float4 shadowColor = (1 - shadow)*surfaceDescription.ShadowTint.rgba;
					float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);

					#ifdef _SURFACE_TYPE_TRANSPARENT
						surfaceData.color = lerp(shadowColor.rgb*surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow), surfaceDescription.Alpha);
					#else
						surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow);
					#endif
					localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
					surfaceDescription.Alpha = localAlpha;
				#endif

				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity = surfaceDescription.Alpha;

				#if defined(DEBUG_DISPLAY)
					builtinData.renderingLayers = GetMeshRenderingLightLayer();
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				#ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif

                ApplyDebugToBuiltinData(builtinData);
			}

			float GetDeExposureMultiplier()
			{
			#if defined(DISABLE_UNLIT_DEEXPOSURE)
				return 1.0;
			#else
				return _DeExposureMultiplier;
			#endif
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.ase_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.ase_texcoord.z , inputMesh.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.ase_texcoord1.z , inputMesh.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord3 = screenPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord1 = inputMesh.ase_texcoord;
				o.ase_texcoord2 = inputMesh.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = staticSwitch360;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = inputMesh.normalOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				o.positionRWS = positionRWS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#ifdef UNITY_VIRTUAL_TEXTURING
			#define VT_BUFFER_TARGET SV_Target1
			#define EXTRA_BUFFER_TARGET SV_Target2
			#else
			#define EXTRA_BUFFER_TARGET SV_Target1
			#endif

			void Frag( VertexOutput packedInput,
						out float4 outColor : SV_Target0
						#ifdef UNITY_VIRTUAL_TEXTURING
						,out float4 outVTFeedback : VT_BUFFER_TARGET
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
					, bool ase_vface : SV_IsFrontFace
					)
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.positionRWS;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir( input.positionRWS );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 appendResult301 = (float3(packedInput.ase_color.r , packedInput.ase_color.g , packedInput.ase_color.b));
				float2 uv_MainTex = packedInput.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord1.z , packedInput.ase_texcoord1.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord1.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord2.z , packedInput.ase_texcoord2.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				float4 temp_cast_1 = (_TextureLevels).xxxx;
				float4 temp_output_72_0 = pow( tex2DNode1 , temp_cast_1 );
				float3 appendResult302 = (float3(packedInput.ase_color.r , packedInput.ase_color.g , packedInput.ase_color.b));
				float2 appendResult229 = (float2(_GradientMapValues.x , _GradientMapValues.x));
				float2 appendResult230 = (float2(_GradientMapValues.y , _GradientMapValues.y));
				float2 appendResult140 = (float2(temp_output_72_0.rg));
				float2 smoothstepResult227 = smoothstep( appendResult229 , appendResult230 , appendResult140);
				float2 clampResult291 = clamp( smoothstepResult227 , float2( 0.1,0.1 ) , float2( 0.9,0.9 ) );
				#ifdef _USEGRADIENTMAP_ON
				float4 staticSwitch137 = ( float4( appendResult302 , 0.0 ) * tex2D( _GradientMap, clampResult291 ) );
				#else
				float4 staticSwitch137 = ( float4( appendResult301 , 0.0 ) * temp_output_72_0 );
				#endif
				float3 appendResult303 = (float3(_Color.r , _Color.g , _Color.b));
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float2 texCoord108 = packedInput.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord3;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				float4 temp_output_94_0 = ( ( _EmissiveIntensity * ( staticSwitch137 * float4( appendResult303 , 0.0 ) * texAlpha270 ) ) * _FinalMix * UVMaskType275 * packedInput.ase_color.a * distanceDepth305 );
				float4 MainTex345 = temp_output_72_0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float3 objToWorld285 = GetAbsolutePositionWS(mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz);
				float temp_output_187_0 = distance( ase_worldPos , objToWorld285 );
				float WorldCenter278 = saturate( -(0.0 + (( temp_output_187_0 - _CenterColorSize ) - ( 1.0 - _CenterSmoothness )) * (1.0 - 0.0) / (1.0 - ( 1.0 - _CenterSmoothness ))) );
				float4 lerpResult348 = lerp( temp_output_94_0 , ( _WorldCenterColor * MainTex345 ) , WorldCenter278);
				float4 lerpResult340 = lerp( ( lerpResult348 * _2SidedInt ) , temp_output_94_0 , ase_vface);
				#if defined(_USE2SIDEDCOLOR_FALSE)
				float4 staticSwitch343 = temp_output_94_0;
				#elif defined(_USE2SIDEDCOLOR_TRUE)
				float4 staticSwitch343 = lerpResult340;
				#else
				float4 staticSwitch343 = temp_output_94_0;
				#endif
				float4 lerpResult377 = lerp( staticSwitch343 , _HitColor , _HitEffect);
				
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				
				surfaceDescription.Color = lerpResult377.rgb;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				surfaceDescription.ShadowTint = float4( 0, 0 ,0 ,1 );
				float2 Distortion = float2 ( 0, 0 );
				float DistortionBlur = 0;

				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData( input.positionSS.xy, surfaceData );

				#if defined(_ENABLE_SHADOW_MATTE)
				bsdfData.color *= GetScreenSpaceAmbientOcclusion(input.positionSS.xy);
				#endif


			#ifdef DEBUG_DISPLAY
				if (_DebugLightingMode >= DEBUGLIGHTINGMODE_DIFFUSE_LIGHTING && _DebugLightingMode <= DEBUGLIGHTINGMODE_EMISSIVE_LIGHTING)
				{
					if (_DebugLightingMode != DEBUGLIGHTINGMODE_EMISSIVE_LIGHTING)
					{
						builtinData.emissiveColor = 0.0;
					}
					else
					{
						bsdfData.color = 0.0;
					}
				}
			#endif

				float4 outResult = ApplyBlendMode(bsdfData.color * GetDeExposureMultiplier() + builtinData.emissiveColor * GetCurrentExposureMultiplier(), builtinData.opacity);
				outResult = EvaluateAtmosphericScattering(posInput, V, outResult);

				#ifdef DEBUG_DISPLAY
					int bufferSize = int(_DebugViewMaterialArray[0].x);
					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = int(_DebugViewMaterialArray[index].x);
						if (indexMaterialProperty != 0)
						{
							float3 result = float3(1.0, 0.0, 1.0);
							bool needLinearToSRGB = false;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, posInput, result, needLinearToSRGB);
							GetSurfaceDataDebug(indexMaterialProperty, surfaceData, result, needLinearToSRGB);
							GetBSDFDataDebug(indexMaterialProperty, bsdfData, result, needLinearToSRGB);

							if (!needLinearToSRGB)
								result = SRGBToLinear(max(0, result));

							outResult = float4(result, 1.0);
						}
					}

					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outResult = result;
					}
				#endif

				outColor = outResult;

				#ifdef _DEPTHOFFSET_ON
					outputDepth = posInput.deviceDepth;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
					outVTFeedback = builtinData.vtPackedFeedback;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#pragma shader_feature EDITOR_VISUALIZATION

			#pragma vertex Vert
			#pragma fragment Frag

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			#define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;
			sampler2D _GradientMap;
			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;


            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _USE2SIDEDCOLOR_FALSE _USE2SIDEDCOLOR_TRUE
			#pragma shader_feature_local _USEGRADIENTMAP_ON
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				#ifdef EDITOR_VISUALIZATION
				float2 VizUV : TEXCOORD0;
				float4 LightCoord : TEXCOORD1;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};


			
			struct SurfaceDescription
			{
				float3 Color;
				float3 Emission;
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData( FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData )
			{
				ZERO_INITIALIZE( SurfaceData, surfaceData );
				surfaceData.color = surfaceDescription.Color;

				#ifdef WRITE_NORMAL_BUFFER
				surfaceData.normalWS = fragInputs.tangentToWorld[2];
				#endif
			}

			void GetSurfaceAndBuiltinData( SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData )
			{
				#ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

				#if _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#if _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

				BuildSurfaceData( fragInputs, surfaceDescription, V, surfaceData );
				ZERO_INITIALIZE( BuiltinData, builtinData );
				builtinData.opacity = surfaceDescription.Alpha;
				#if defined(DEBUG_DISPLAY)
					builtinData.renderingLayers = GetMeshRenderingLightLayer();
				#endif

				#ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				#if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif


                ApplyDebugToBuiltinData(builtinData);
			}

			#define SCENEPICKINGPASS
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/MetaPass.hlsl"

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID( inputMesh );
				UNITY_TRANSFER_INSTANCE_ID( inputMesh, o );

				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.uv0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.uv0.z , inputMesh.uv0.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.uv0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.uv1.z , inputMesh.uv1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				o.ase_texcoord5.xyz = ase_worldPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord2 = inputMesh.uv0;
				o.ase_texcoord3 = inputMesh.uv1;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = staticSwitch360;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

			#ifdef EDITOR_VISUALIZATION
				float2 vizUV = 0;
				float4 lightCoord = 0;
				UnityEditorVizData(inputMesh.positionOS.xyz, inputMesh.uv0.xy, inputMesh.uv1.xy, inputMesh.uv2.xy, vizUV, lightCoord);
			#endif

				float2 uv = float2( 0.0, 0.0 );
				if( unity_MetaVertexControl.x )
				{
					uv = inputMesh.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				}
				else if( unity_MetaVertexControl.y )
				{
					uv = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				}

				#ifdef EDITOR_VISUALIZATION
					o.VizUV.xy = vizUV;
					o.LightCoord = lightCoord;
				#endif

				o.positionCS = float4( uv * 2.0 - 1.0, inputMesh.positionOS.z > 0 ? 1.0e-4 : 0.0, 1.0 );
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.uv3 = v.uv3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.uv3 = patch[0].uv3 * bary.x + patch[1].uv3 * bary.y + patch[2].uv3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag( VertexOutput packedInput , bool ase_vface : SV_IsFrontFace ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE( FragInputs, input );
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS );

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float3 appendResult301 = (float3(packedInput.ase_color.r , packedInput.ase_color.g , packedInput.ase_color.b));
				float2 uv_MainTex = packedInput.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord2.z , packedInput.ase_texcoord2.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord2.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord3.z , packedInput.ase_texcoord3.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				float4 temp_cast_1 = (_TextureLevels).xxxx;
				float4 temp_output_72_0 = pow( tex2DNode1 , temp_cast_1 );
				float3 appendResult302 = (float3(packedInput.ase_color.r , packedInput.ase_color.g , packedInput.ase_color.b));
				float2 appendResult229 = (float2(_GradientMapValues.x , _GradientMapValues.x));
				float2 appendResult230 = (float2(_GradientMapValues.y , _GradientMapValues.y));
				float2 appendResult140 = (float2(temp_output_72_0.rg));
				float2 smoothstepResult227 = smoothstep( appendResult229 , appendResult230 , appendResult140);
				float2 clampResult291 = clamp( smoothstepResult227 , float2( 0.1,0.1 ) , float2( 0.9,0.9 ) );
				#ifdef _USEGRADIENTMAP_ON
				float4 staticSwitch137 = ( float4( appendResult302 , 0.0 ) * tex2D( _GradientMap, clampResult291 ) );
				#else
				float4 staticSwitch137 = ( float4( appendResult301 , 0.0 ) * temp_output_72_0 );
				#endif
				float3 appendResult303 = (float3(_Color.r , _Color.g , _Color.b));
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float2 texCoord108 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				float4 temp_output_94_0 = ( ( _EmissiveIntensity * ( staticSwitch137 * float4( appendResult303 , 0.0 ) * texAlpha270 ) ) * _FinalMix * UVMaskType275 * packedInput.ase_color.a * distanceDepth305 );
				float4 MainTex345 = temp_output_72_0;
				float3 ase_worldPos = packedInput.ase_texcoord5.xyz;
				float3 objToWorld285 = GetAbsolutePositionWS(mul( GetObjectToWorldMatrix(), float4( float3( 0,0,0 ), 1 ) ).xyz);
				float temp_output_187_0 = distance( ase_worldPos , objToWorld285 );
				float WorldCenter278 = saturate( -(0.0 + (( temp_output_187_0 - _CenterColorSize ) - ( 1.0 - _CenterSmoothness )) * (1.0 - 0.0) / (1.0 - ( 1.0 - _CenterSmoothness ))) );
				float4 lerpResult348 = lerp( temp_output_94_0 , ( _WorldCenterColor * MainTex345 ) , WorldCenter278);
				float4 lerpResult340 = lerp( ( lerpResult348 * _2SidedInt ) , temp_output_94_0 , ase_vface);
				#if defined(_USE2SIDEDCOLOR_FALSE)
				float4 staticSwitch343 = temp_output_94_0;
				#elif defined(_USE2SIDEDCOLOR_TRUE)
				float4 staticSwitch343 = lerpResult340;
				#else
				float4 staticSwitch343 = temp_output_94_0;
				#endif
				float4 lerpResult377 = lerp( staticSwitch343 , _HitColor , _HitEffect);
				
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				
				surfaceDescription.Color = lerpResult377.rgb;
				surfaceDescription.Emission = 0;
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData( surfaceDescription,input, V, posInput, surfaceData, builtinData );

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData( input.positionSS.xy, surfaceData );
				LightTransportData lightTransportData = GetLightTransportData( surfaceData, builtinData, bsdfData );

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				UnityMetaInput metaInput;
				metaInput.Albedo = lightTransportData.diffuseColor.rgb;
				metaInput.Emission = lightTransportData.emissiveColor;
			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = packedInput.VizUV;
				metaInput.LightCoord = packedInput.LightCoord;
			#endif
				res = UnityMetaFragment(metaInput);

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off

			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENESELECTIONPASS 1
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			int _ObjectId;
			int _PassValue;

			CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				#ifdef WRITE_NORMAL_BUFFER
				surfaceData.normalWS = fragInputs.tangentToWorld[2];
				#endif
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;

				#ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				#if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif


                ApplyDebugToBuiltinData(builtinData);
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.ase_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.ase_texcoord.z , inputMesh.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.ase_texcoord1.z , inputMesh.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord2 = screenPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord = inputMesh.ase_texcoord;
				o.ase_texcoord1 = inputMesh.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  staticSwitch360;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
					, out float4 outColor : SV_Target0
					#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
					#endif
					
					)
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceData surfaceData;
				BuiltinData builtinData;
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_MainTex = packedInput.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord.z , packedInput.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord1.z , packedInput.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				float2 texCoord108 = packedInput.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthForwardOnly"
			Tags { "LightMode"="DepthForwardOnly" }

			Cull [_CullMode]
			ZWrite On
			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
			}


			ColorMask 0 0

			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_Position;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				#ifdef WRITE_NORMAL_BUFFER
				surfaceData.normalWS = fragInputs.tangentToWorld[2];
				#endif
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#if _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;

				#if defined(DEBUG_DISPLAY)
					builtinData.renderingLayers = GetMeshRenderingLightLayer();
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				#if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif

                ApplyDebugToBuiltinData(builtinData);
			}

			VertexOutput VertexFunction( VertexInput inputMesh  )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.ase_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.ase_texcoord.z , inputMesh.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.ase_texcoord1.z , inputMesh.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord2 = screenPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord = inputMesh.ase_texcoord;
				o.ase_texcoord1 = inputMesh.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  staticSwitch360;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				o.positionCS = TransformWorldToHClip(positionRWS);
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
						#ifdef WRITE_MSAA_DEPTH
						, out float4 depthColor : SV_Target0
							#ifdef WRITE_NORMAL_BUFFER
							, out float4 outNormalBuffer : SV_Target1
							#endif
						#else
							#ifdef WRITE_NORMAL_BUFFER
							, out float4 outNormalBuffer : SV_Target0
							#endif
						#endif
						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
					
					)
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = float3( 1.0, 1.0, 1.0 );

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_MainTex = packedInput.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord.z , packedInput.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord1.z , packedInput.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				float2 texCoord108 = packedInput.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord2;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.positionCS.z;
					#ifdef _ALPHATOMASK_ON
					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
					#endif
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
					EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "MotionVectors"
			Tags { "LightMode"="MotionVectors" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma vertex Vert
			#pragma fragment Frag

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			#define SHADERPASS SHADERPASS_MOTION_VECTORS
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				#ifdef WRITE_NORMAL_BUFFER
				surfaceData.normalWS = fragInputs.tangentToWorld[2];
				#endif
			}

			void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

				#if _ALPHATEST_ON
				DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#if _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

				BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
				ZERO_INITIALIZE(BuiltinData, builtinData);
				builtinData.opacity =  surfaceDescription.Alpha;

				#if defined(DEBUG_DISPLAY)
                    builtinData.renderingLayers = GetMeshRenderingLightLayer();
                #endif


                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif


                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif

                ApplyDebugToBuiltinData(builtinData);
			}

			VertexInput ApplyMeshModification(VertexInput inputMesh, float3 timeParameters, inout VertexOutput o )
			{
				_TimeParameters.xyz = timeParameters;
				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.ase_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.ase_texcoord.z , inputMesh.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.ase_texcoord1.z , inputMesh.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord5 = screenPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord3 = inputMesh.ase_texcoord;
				o.ase_texcoord4 = inputMesh.ase_texcoord1;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = staticSwitch360;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS =  inputMesh.normalOS ;
				return inputMesh;
			}

			VertexOutput VertexFunction(VertexInput inputMesh)
			{
				VertexOutput o = (VertexOutput)0;
				VertexInput defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, o);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				float3 VMESHpositionRWS = positionRWS;
				float4 VMESHpositionCS = TransformWorldToHClip(positionRWS);

				//#if defined(UNITY_REVERSED_Z)
				//	VMESHpositionCS.z -= unity_MotionVectorsParams.z * VMESHpositionCS.w;
				//#else
				//	VMESHpositionCS.z += unity_MotionVectorsParams.z * VMESHpositionCS.w;
				//#endif

				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(VMESHpositionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						VertexInput previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						VertexOutput test = (VertexOutput)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}

				o.vmeshPositionCS = VMESHpositionCS;
				o.vmeshInterp00.xyz = VMESHpositionRWS;

				o.vpassInterpolators0 = float3(VPASSpositionCS.xyw);
				o.vpassInterpolators1 = float3(VPASSpreviousPositionCS.xyw);
				return o;
			}

			#if ( 0 ) // TEMPORARY: defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.previousPositionOS = v.previousPositionOS;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = v.precomputedVelocity;
				#endif
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
				#endif
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( VertexOutput packedInput
						#ifdef WRITE_MSAA_DEPTH
						, out float4 depthColor : SV_Target0
						, out float4 outMotionVector : SV_Target1
							#ifdef WRITE_DECAL_BUFFER
							, out float4 outDecalBuffer : SV_Target2
							#endif
						#else
						, out float4 outMotionVector : SV_Target0
							#ifdef WRITE_DECAL_BUFFER
							, out float4 outDecalBuffer : SV_Target1
							#endif
						#endif

						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_TARGET_NORMAL
						#endif

						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.vmeshPositionCS;
				input.positionRWS = packedInput.vmeshInterp00.xyz;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_MainTex = packedInput.ase_texcoord3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord3.z , packedInput.ase_texcoord3.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord3.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord4.z , packedInput.ase_texcoord4.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				float2 texCoord108 = packedInput.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord5;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				float4 VPASSpositionCS = float4(packedInput.vpassInterpolators0.xy, 0.0, packedInput.vpassInterpolators0.z);
				float4 VPASSpreviousPositionCS = float4(packedInput.vpassInterpolators1.xy, 0.0, packedInput.vpassInterpolators1.z);

				#ifdef _DEPTHOFFSET_ON
				VPASSpositionCS.w += builtinData.depthOffset;
				VPASSpreviousPositionCS.w += builtinData.depthOffset;
				#endif

				float2 motionVector = CalculateMotionVector( VPASSpositionCS, VPASSpreviousPositionCS );
				EncodeMotionVector( motionVector * 0.5, outMotionVector );

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if( forceNoMotion )
					outMotionVector = float4( 2.0, 0.0, 0.0, 0.0 );

				// Depth and Alpha to coverage
				#ifdef WRITE_MSAA_DEPTH
					// In case we are rendering in MSAA, reading the an MSAA depth buffer is way too expensive. To avoid that, we export the depth to a color buffer
					depthColor = packedInput.vmeshPositionCS.z;

					// Alpha channel is used for alpha to coverage
					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif

				// Normal Buffer Processing
				#ifdef WRITE_NORMAL_BUFFER
					EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

				#if defined(WRITE_DECAL_BUFFER)
					DecalPrepassData decalPrepassData;
					#ifdef _DISABLE_DECALS
					ZERO_INITIALIZE(DecalPrepassData, decalPrepassData);
					#else
					decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
					decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
					#endif
					EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);

					// make sure we don't overwrite light layers
					outDecalBuffer.w = (GetMeshRenderingLightLayer() & 0x000000FF) / 255.0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
        Pass
		{
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull [_CullMode]

			HLSLPROGRAM

			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define HAVE_MESH_MODIFICATION 1
			#define ASE_SRP_VERSION 140008


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC

			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define VARYINGS_NEED_TANGENT_TO_WORLD

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENEPICKINGPASS 1

			#define SHADER_UNLIT

			float4 _SelectionID;

            CBUFFER_START( UnityPerMaterial )
			float4 _Color;
			float4 _MainTex_ST;
			float4 _DistortTex_ST;
			float4 _HitColor;
			float4 _GradientMapValues;
			float4 _WorldCenterColor;
			float2 _TexturePanSpeed;
			float2 _DistortPanSpeed;
			float _2SidedInt;
			float _CenterSmoothness;
			float _CenterColorSize;
			float _DFDistance;
			float _MaskOffset;
			float _VertexOffset;
			float _FinalMix;
			float _HitEffect;
			float _TextureLevels;
			float _EmissiveIntensity;
			float _TexAlphaPower;
			float _Distort;
			float _MaskPower;
			float _OpacityInt;
			float4 _EmissionColor;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			#ifdef _ENABLE_SHADOW_MATTE
			float _ShadowMatteFilter;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _AlphaCutoff;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			float _EnableBlendModePreserveSpecularLighting;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;


            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _USEDISTTEX_ON
			#pragma shader_feature_local _TEXHASASLPHA_TRUE _TEXHASASLPHA_FALSE
			#pragma shader_feature_local _USEDISTORT_ON
			#pragma shader_feature_local _PANTYPE_PANNER _PANTYPE_CUSTOM
			#pragma shader_feature_local _INVERTMASK_ON
			#pragma shader_feature_local _MASKTYPE_NONE _MASKTYPE_U _MASKTYPE_V _MASKTYPE_VCENTER


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float4 tangentWS : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
            struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};


            void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                #ifdef LOD_FADE_CROSSFADE
			        LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif

                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif

                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif


				ZERO_INITIALIZE(SurfaceData, surfaceData);

				ZERO_BUILTIN_INITIALIZE(builtinData);
				builtinData.opacity = surfaceDescription.Alpha;

				#if defined(DEBUG_DISPLAY)
					builtinData.renderingLayers = GetMeshRenderingLightLayer();
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif

                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif


                ApplyDebugToBuiltinData(builtinData);

            }


			VertexOutput VertexFunction(VertexInput inputMesh  )
			{

				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o );

				float3 temp_cast_0 = (0.0).xxx;
				float3 temp_cast_1 = (0.0).xxx;
				float2 uv_MainTex = inputMesh.ase_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(inputMesh.ase_texcoord.z , inputMesh.ase_texcoord.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = inputMesh.ase_texcoord.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(inputMesh.ase_texcoord1.z , inputMesh.ase_texcoord1.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2Dlod( _DistortTex, float4( panner356, 0, 0.0) );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2Dlod( _MainTex, float4( staticSwitch355, 0, 0.0) );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float DistortTex367 = tex2DNode351.r;
				#ifdef _USEDISTTEX_ON
				float staticSwitch368 = DistortTex367;
				#else
				float staticSwitch368 = texAlpha270;
				#endif
				float3 lerpResult209 = lerp( temp_cast_1 , ( _VertexOffset * inputMesh.normalOS ) , staticSwitch368);
				float3 VertexOffset272 = lerpResult209;
				#ifdef _USEVERTEXOFFSET_ON
				float3 staticSwitch360 = VertexOffset272;
				#else
				float3 staticSwitch360 = temp_cast_0;
				#endif
				
				float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
				float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
				o.ase_texcoord4 = screenPos;
				
				o.ase_color = inputMesh.ase_color;
				o.ase_texcoord2 = inputMesh.ase_texcoord;
				o.ase_texcoord3 = inputMesh.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  staticSwitch360;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				o.positionCS = TransformWorldToHClip(positionRWS);
				o.normalWS.xyz =  normalWS;
				o.tangentWS.xyzw =  tangentWS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag(	VertexOutput packedInput
						, out float4 outColor : SV_Target0
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS.xyzw, packedInput.normalWS.xyz);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_MainTex = packedInput.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 panner34 = ( 1.0 * _Time.y * _TexturePanSpeed + uv_MainTex);
				float2 appendResult52 = (float2(packedInput.ase_texcoord2.z , packedInput.ase_texcoord2.w));
				#if defined(_PANTYPE_PANNER)
				float2 staticSwitch50 = panner34;
				#elif defined(_PANTYPE_CUSTOM)
				float2 staticSwitch50 = ( uv_MainTex + appendResult52 );
				#else
				float2 staticSwitch50 = panner34;
				#endif
				float2 uv_DistortTex = packedInput.ase_texcoord2.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
				float2 appendResult374 = (float2(packedInput.ase_texcoord3.z , packedInput.ase_texcoord3.w));
				float2 panner356 = ( 1.0 * _Time.y * _DistortPanSpeed + ( uv_DistortTex + appendResult374 ));
				float4 tex2DNode351 = tex2D( _DistortTex, panner356 );
				#ifdef _USEDISTORT_ON
				float2 staticSwitch355 = ( staticSwitch50 + ( tex2DNode351.r * _Distort ) );
				#else
				float2 staticSwitch355 = staticSwitch50;
				#endif
				float4 tex2DNode1 = tex2D( _MainTex, staticSwitch355 );
				#if defined(_TEXHASASLPHA_TRUE)
				float staticSwitch71 = tex2DNode1.a;
				#elif defined(_TEXHASASLPHA_FALSE)
				float staticSwitch71 = tex2DNode1.r;
				#else
				float staticSwitch71 = tex2DNode1.a;
				#endif
				float texAlpha270 = pow( staticSwitch71 , _TexAlphaPower );
				float temp_output_99_0 = ( _Color.a * packedInput.ase_color.a * texAlpha270 );
				float2 texCoord108 = packedInput.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_MASKTYPE_NONE)
				float staticSwitch110 = 1.0;
				#elif defined(_MASKTYPE_U)
				float staticSwitch110 = ( pow( texCoord108.x , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_V)
				float staticSwitch110 = ( pow( texCoord108.y , _MaskPower ) + _MaskOffset );
				#elif defined(_MASKTYPE_VCENTER)
				float staticSwitch110 = ( _MaskOffset + ( texCoord108.x * ( 1.0 - texCoord108.x ) ) );
				#else
				float staticSwitch110 = 1.0;
				#endif
				#ifdef _INVERTMASK_ON
				float staticSwitch115 = ( 1.0 - staticSwitch110 );
				#else
				float staticSwitch115 = staticSwitch110;
				#endif
				float UVMaskType275 = saturate( staticSwitch115 );
				float4 screenPos = packedInput.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth305 = LinearEyeDepth(SampleCameraDepth( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth305 = saturate( abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DFDistance ) ) );
				
				surfaceDescription.Alpha = saturate( ( ( temp_output_99_0 * ( temp_output_99_0 * _OpacityInt ) ) * UVMaskType275 * distanceDepth305 ) );
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;


				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);
				outColor = _SelectionID;
			}

            ENDHLSL
        }

		Pass
		{

            Name "FullScreenDebug"
            Tags 
			{ 
				"LightMode" = "FullScreenDebug" 
			}

            Cull [_CullMode]
			ZTest LEqual
			ZWrite Off

			HLSLPROGRAM

			/*ase_pragma_before*/

			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer

			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC

			#pragma vertex Vert
			#pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT

            #define SHADERPASS SHADERPASS_FULL_SCREEN_DEBUG
			#define SHADER_UNLIT

            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
            #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            struct AttributesMesh
			{
				 float3 positionOS : POSITION;
				 float3 normalOS : NORMAL;
				 float4 tangentOS : TANGENT;
				#if UNITY_ANY_INSTANCING_ENABLED
				 uint instanceID : INSTANCEID_SEMANTIC;
				#endif
			};

			struct VaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
				 uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

			struct VertexDescriptionInputs
			{
				 float3 ObjectSpaceNormal;
				 float3 ObjectSpaceTangent;
				 float3 ObjectSpacePosition;
			};

			struct SurfaceDescriptionInputs
			{
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
				 uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

			PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
			{
				PackedVaryingsMeshToPS output;
				ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

			VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
			{
				VaryingsMeshToPS output;
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

            struct VertexDescription
			{
				float3 Position;
				float3 Normal;
				float3 Tangent;
			};

			VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
			{
				VertexDescription description = (VertexDescription)0;
				description.Position = IN.ObjectSpacePosition;
				description.Normal = IN.ObjectSpaceNormal;
				description.Tangent = IN.ObjectSpaceTangent;
				return description;
			}


            struct SurfaceDescription
			{
				float3 BaseColor;
				float3 Emission;
				float Alpha;
			};

			SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
			{
				SurfaceDescription surface = (SurfaceDescription)0;
				surface.BaseColor = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
				surface.Emission = float3(0, 0, 0);
				surface.Alpha = 1;
				return surface;
			}



			VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
			{
				VertexDescriptionInputs output;
				ZERO_INITIALIZE(VertexDescriptionInputs, output);
				output.ObjectSpaceNormal =                          input.normalOS;
				output.ObjectSpaceTangent =                         input.tangentOS.xyz;
				output.ObjectSpacePosition =                        input.positionOS;
				return output;
			}

			AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters )
			{
				VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
				VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
				input.positionOS = vertexDescription.Position;
				input.normalOS = vertexDescription.Normal;
				input.tangentOS.xyz = vertexDescription.Tangent;
				return input;
			}

			FragInputs BuildFragInputs(VaryingsMeshToPS input)
			{
				FragInputs output;
				ZERO_INITIALIZE(FragInputs, output);

				output.tangentToWorld = k_identity3x3;
				output.positionSS = input.positionCS;

				return output;
			}


			FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
			{
				UNITY_SETUP_INSTANCE_ID(input);
				VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
				return BuildFragInputs(unpacked);
			}
				SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
			{
				SurfaceDescriptionInputs output;
				ZERO_INITIALIZE(SurfaceDescriptionInputs, output);


        		return output;
			}

			#define DEBUG_DISPLAY
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/FullScreenDebug.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/VertMesh.hlsl"

			PackedVaryingsType Vert(AttributesMesh inputMesh)
			{
				VaryingsType varyingsType;
				varyingsType.vmesh = VertMesh(inputMesh);
				return PackVaryingsType(varyingsType);
			}

			#if !defined(_DEPTHOFFSET_ON)
			[earlydepthstencil]
			#endif
			void Frag(PackedVaryingsToPS packedInput)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				FragInputs input = UnpackVaryingsToFragInputs(packedInput);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz);

			#ifdef PLATFORM_SUPPORTS_PRIMITIVE_ID_IN_PIXEL_SHADER
				if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_QUAD_OVERDRAW)
				{
					IncrementQuadOverdrawCounter(posInput.positionSS.xy, input.primitiveID);
				}
			#endif
			}

            ENDHLSL
        }
		
	}
	
	CustomEditor "Rendering.HighDefinition.HDUnlitGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=19200
Node;AmplifyShaderEditor.CommentaryNode;276;1055.632,1249.54;Inherit;False;2706.333;831.5343;UV Mask;16;275;297;115;116;110;111;128;129;113;112;130;108;114;334;335;336;UV Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;113;1575.063,1541.848;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;128;1993.158,1319.147;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;2040.786,1410.453;Inherit;False;Constant;_1;1;18;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1247.334,-84.23723;Inherit;True;Property;_MainTex;MainTex;0;1;[Header];Create;True;2;Main Texture;.;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;116;2544.846,1421.64;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;115;2773.988,1310.141;Inherit;True;Property;_Invertmask;Invert mask;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;297;3089.392,1317.853;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;274;811.8411,2390.938;Inherit;False;1440.027;581.8572;Vertex Offset;9;271;366;365;211;272;209;210;368;369;Vertex Offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;275;3338.947,1303.886;Inherit;False;UVMaskType;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;277;2364.903,2389.938;Inherit;False;1782.074;529.3337;World Center;14;278;206;187;199;190;224;188;244;208;189;245;192;253;285;World Center;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;304;1364.944,-139.5827;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;72;-721.8896,-401.4174;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;229;-447.0458,24.15591;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;230;-388.0458,113.1559;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;301;300.4512,-569.9586;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;138;78.77661,-169.5415;Inherit;True;Property;_GradientMap;Gradient Map;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;140;-492.4338,-76.6626;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;291;-91.63232,-147.3002;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.1,0.1;False;2;FLOAT2;0.9,0.9;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;500.5389,-407.136;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;302;306.4512,-337.9586;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;141;-207.4338,92.3374;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.1,0.1;False;2;FLOAT2;0.9,0.9;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;54;82.84537,-568.7377;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;303;536.4512,68.04138;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;227;-299.7458,-137.0441;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;299;430.5312,-223.1785;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;1488.649,234.8796;Float;False;Property;_FinalMix;FinalMix;7;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;319;1666.248,799.4365;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;330;1209.515,216.8491;Inherit;True;-1;;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;105;201.0267,98.1167;Inherit;False;Property;_Color;Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;4.759381,4.759381,4.759381,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;137;631.3922,-254.8156;Inherit;False;Property;_UseGradientMap;Use Gradient Map;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;825.4258,132.2608;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;1329.71,105.9568;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;102;1127.008,24.78011;Float;False;Property;_EmissiveIntensity;EmissiveIntensity;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;1808.01,71.86322;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;210;1070.841,2440.938;Inherit;False;Constant;_Float1;Float 1;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;192;2700.575,2484.756;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;208;2892.897,2792.271;Inherit;False;Property;_CenterSmoothness;Center Smoothness;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;245;3100.507,2792.746;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;206;3273.597,2625.672;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;278;3800.454,2640.166;Inherit;False;WorldCenter;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;224;2662.373,2631.175;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;253;2434.731,2439.938;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;244;3052.507,2515.747;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;189;3067.476,2624.255;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;199;3495.864,2624.733;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;188;3638.977,2642.455;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;112;1581.063,1322.848;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;1846.489,1437.147;Inherit;False;Property;_MaskOffset;Mask Offset;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;108;1084.632,1298.54;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;335;1427.244,1905.818;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;1582.244,1792.818;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;2033.467,1562.136;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;336;2022.244,1797.818;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;110;2252.111,1315.526;Inherit;True;Property;_MaskType;Mask Type;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;None;U;V;VCenter;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;1395.958,1433.227;Inherit;False;Property;_MaskPower;Mask Power;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;337;1251.28,801.0387;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;300;342.7387,561.8298;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;298;1439.588,405.1009;Inherit;False;275;UVMaskType;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;665.1472,354.757;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;338;1147.752,475.8803;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-822.3933,-108.2942;Inherit;False;Property;_TextureLevels;Texture Levels;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;228;-726.2458,1.555913;Inherit;False;Property;_GradientMapValues;Gradient Map Values;11;0;Create;True;0;0;0;False;0;False;0,0,1,1;0,1.85,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;71;-740.1045,315.8672;Inherit;False;Property;_Texhasaslpha;Tex has aslpha;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;True;False;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-588.2321,492.2997;Inherit;False;Property;_TexAlphaPower;Tex Alpha Power;3;0;Create;True;0;0;0;False;0;False;1;0.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;286;-410.2324,319.2997;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;270;-79.43298,387.0347;Inherit;False;texAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;864,608;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;343;3707.9,-126.6085;Inherit;False;Property;_Use2SidedColor;Use 2Sided Color;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;False;True;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TransformPositionNode;285;2424.946,2607.134;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;187;2842.676,2517.355;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;2816.676,2691.355;Inherit;False;Property;_CenterColorSize;Center Color Size;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;310;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;311;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;META;0;2;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;312;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;313;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DepthForwardOnly;0;4;DepthForwardOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=DepthForwardOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;315;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;DistortionVectors;0;6;DistortionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;4;1;False;;1;False;;4;1;False;;1;False;;True;1;False;;1;False;;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDistortionVec;255;False;;255;True;_StencilWriteMaskDistortionVec;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;False;True;1;LightMode=DistortionVectors;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;316;2981.676,-60.60687;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;13;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;ScenePickingPass;0;7;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=Picking;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;345;-540.7957,-493.7234;Inherit;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TwoSidedSign;339;3072.9,-137.6084;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;340;3281.9,-262.6084;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;350;2640.309,169.3298;Inherit;False;Property;_2SidedInt;2Sided Int;22;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;351;-2479.721,516.1516;Inherit;True;Property;_DistortTex;DistortTex;24;0;Create;True;0;0;0;False;0;False;-1;None;1402758e2a0168e42963097b9df5517a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;353;-2016.92,548.6517;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;50;-2055.809,-49.97072;Inherit;False;Property;_PanType;PanType;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Panner;Custom;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;355;-1597.021,-35.04807;Inherit;False;Property;_UseDistort;Use Distort;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Panner;Custom;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;352;-1833.621,265.2518;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-2500.349,-73.13551;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;356;-2739.723,544.7518;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-3092.396,-81.87608;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;33;-2832.149,-6.835335;Inherit;False;Property;_TexturePanSpeed;Texture Pan Speed;4;0;Create;True;0;0;0;False;0;False;0,0;1.35,7.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;354;-2165.121,746.2519;Inherit;False;Property;_Distort;Distort;25;0;Create;True;0;0;0;False;0;False;1;0.23;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;2674.185,-423.2001;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;346;2454.294,-320.2347;Inherit;False;345;MainTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;341;2415.619,-491.3823;Inherit;False;Property;_WorldCenterColor;WorldCenter Color;17;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;279;2688.789,-226.5767;Inherit;False;278;WorldCenter;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;348;2965.125,-444.0584;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;349;3140.309,-354.6702;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;309;4196.35,-118.713;Float;False;True;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;15;Gemelli/FX_PannerAddMul;7f5cb9c3ea6481f469fdd856555439ef;True;Forward Unlit;0;0;Forward Unlit;9;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;True;True;3;1;False;_SrcBlend;10;False;_DstBlend;2;5;False;_AlphaSrcBlend;10;False;_AlphaDstBlend;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullModeForward;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVel;False;False;False;False;False;True;True;0;True;_StencilRef;255;False;;255;True;_StencilWriteMask;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;0;True;_ZWrite;True;0;True;_ZTestDepthEqualForOpaque;False;True;1;LightMode=ForwardOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;30;Surface Type;1;638143172383806476;  Rendering Pass ;0;0;  Rendering Pass;1;0;  Blending Mode;1;638143179833212998;  Receive Fog;1;0;  Distortion;0;0;    Distortion Mode;0;0;    Distortion Only;1;0;  Depth Write;1;0;  Cull Mode;0;0;  Depth Test;4;0;Double-Sided;1;638143164111045100;Alpha Clipping;0;0;Motion Vectors;1;0;  Add Precomputed Velocity;0;0;Shadow Matte;0;0;Cast Shadows;0;638143164607135462;DOTS Instancing;0;0;GPU Instancing;1;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;638217292611877947;LOD CrossFade;0;0;0;8;True;False;True;True;True;True;False;True;False;;False;0
Node;AmplifyShaderEditor.StaticSwitch;360;3947.523,171.471;Inherit;False;Property;_UseVertexOffset;UseVertexOffset;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;211;826.446,2514.938;Inherit;False;Property;_VertexOffset;Vertex Offset;28;0;Create;True;0;0;0;False;0;False;0;-0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;365;929.4204,2781.738;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;366;1125.038,2593.771;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;209;1644.05,2593.556;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;367;-2093.154,921.0752;Inherit;False;DistortTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;361;3717.523,180.471;Inherit;False;Constant;_Float0;Float 0;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;273;3706.313,268.9196;Inherit;False;272;VertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;272;2045.796,2601.754;Inherit;False;VertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;271;1265.975,2703.468;Inherit;False;270;texAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;1249.397,2786.804;Inherit;False;367;DistortTex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;368;1442.305,2696.315;Inherit;False;Property;_UseDistTex;UseDistTex;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;370;4196.35,90.287;Float;False;False;-1;2;Rendering.HighDefinition.HDUnlitGUI;0;1;New Amplify Shader;7f5cb9c3ea6481f469fdd856555439ef;True;MotionVectors;0;5;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefMV;255;False;;255;True;_StencilWriteMaskMV;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=MotionVectors;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.RangedFloatNode;293;123.7193,756.4434;Inherit;False;Property;_OpacityInt;OpacityInt;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;358;-3080.837,657.6218;Inherit;False;Property;_DistortPanSpeed;Distort Pan Speed;26;0;Create;True;0;0;0;False;0;False;0,0;0,3.02;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;51;-2836.909,172.8293;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-2249.512,101.5221;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-2537.809,246.0293;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;357;-3457.221,357.7519;Inherit;False;0;351;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;373;-3011.83,369.0797;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;374;-3287.127,565.5868;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;372;-3558.038,520.4915;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;371;1862.356,804.4928;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;305;1363.053,925.7697;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;306;1145.053,956.7697;Inherit;False;Property;_DFDistance;DF Distance;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;376;3479.65,-236.0588;Inherit;False;Property;_HitEffect;HitEffect;31;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;378;3537.031,-453.5988;Inherit;False;Property;_HitColor;HitColor;30;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;377;3962.232,-385.5988;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;4172.949,-394.1128;Inherit;False;BC;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
WireConnection;113;0;108;2
WireConnection;113;1;114;0
WireConnection;128;0;112;0
WireConnection;128;1;130;0
WireConnection;1;1;355;0
WireConnection;116;0;110;0
WireConnection;115;1;110;0
WireConnection;115;0;116;0
WireConnection;297;0;115;0
WireConnection;275;0;297;0
WireConnection;72;0;1;0
WireConnection;72;1;74;0
WireConnection;229;0;228;1
WireConnection;229;1;228;1
WireConnection;230;0;228;2
WireConnection;230;1;228;2
WireConnection;301;0;54;1
WireConnection;301;1;54;2
WireConnection;301;2;54;3
WireConnection;138;1;291;0
WireConnection;140;0;72;0
WireConnection;291;0;227;0
WireConnection;55;0;301;0
WireConnection;55;1;72;0
WireConnection;302;0;54;1
WireConnection;302;1;54;2
WireConnection;302;2;54;3
WireConnection;303;0;105;1
WireConnection;303;1;105;2
WireConnection;303;2;105;3
WireConnection;227;0;140;0
WireConnection;227;1;229;0
WireConnection;227;2;230;0
WireConnection;299;0;302;0
WireConnection;299;1;138;0
WireConnection;319;0;338;0
WireConnection;319;1;298;0
WireConnection;319;2;305;0
WireConnection;137;1;55;0
WireConnection;137;0;299;0
WireConnection;103;0;137;0
WireConnection;103;1;303;0
WireConnection;103;2;270;0
WireConnection;104;0;102;0
WireConnection;104;1;103;0
WireConnection;94;0;104;0
WireConnection;94;1;96;0
WireConnection;94;2;298;0
WireConnection;94;3;304;4
WireConnection;94;4;305;0
WireConnection;192;0;253;1
WireConnection;192;1;253;3
WireConnection;245;0;208;0
WireConnection;206;0;244;0
WireConnection;206;1;245;0
WireConnection;278;0;188;0
WireConnection;224;0;285;1
WireConnection;224;1;285;3
WireConnection;244;0;187;0
WireConnection;244;1;190;0
WireConnection;189;0;187;0
WireConnection;189;1;190;0
WireConnection;199;0;206;0
WireConnection;188;0;199;0
WireConnection;112;0;108;1
WireConnection;112;1;114;0
WireConnection;335;0;108;1
WireConnection;334;0;108;1
WireConnection;334;1;335;0
WireConnection;129;0;113;0
WireConnection;129;1;130;0
WireConnection;336;0;130;0
WireConnection;336;1;334;0
WireConnection;110;1;111;0
WireConnection;110;0;128;0
WireConnection;110;2;129;0
WireConnection;110;3;336;0
WireConnection;99;0;105;4
WireConnection;99;1;300;4
WireConnection;99;2;270;0
WireConnection;338;0;99;0
WireConnection;338;1;101;0
WireConnection;71;1;1;4
WireConnection;71;0;1;1
WireConnection;286;0;71;0
WireConnection;286;1;287;0
WireConnection;270;0;286;0
WireConnection;101;0;99;0
WireConnection;101;1;293;0
WireConnection;343;1;94;0
WireConnection;343;0;340;0
WireConnection;187;0;253;0
WireConnection;187;1;285;0
WireConnection;345;0;72;0
WireConnection;340;0;349;0
WireConnection;340;1;94;0
WireConnection;340;2;339;0
WireConnection;351;1;356;0
WireConnection;353;0;351;1
WireConnection;353;1;354;0
WireConnection;50;1;34;0
WireConnection;50;0;53;0
WireConnection;355;1;50;0
WireConnection;355;0;352;0
WireConnection;352;0;50;0
WireConnection;352;1;353;0
WireConnection;34;0;32;0
WireConnection;34;2;33;0
WireConnection;356;0;373;0
WireConnection;356;2;358;0
WireConnection;342;0;341;0
WireConnection;342;1;346;0
WireConnection;348;0;94;0
WireConnection;348;1;342;0
WireConnection;348;2;279;0
WireConnection;349;0;348;0
WireConnection;349;1;350;0
WireConnection;309;0;377;0
WireConnection;309;2;371;0
WireConnection;309;6;360;0
WireConnection;360;1;361;0
WireConnection;360;0;273;0
WireConnection;366;0;211;0
WireConnection;366;1;365;0
WireConnection;209;0;210;0
WireConnection;209;1;366;0
WireConnection;209;2;368;0
WireConnection;367;0;351;1
WireConnection;272;0;209;0
WireConnection;368;1;271;0
WireConnection;368;0;369;0
WireConnection;53;0;32;0
WireConnection;53;1;52;0
WireConnection;52;0;51;3
WireConnection;52;1;51;4
WireConnection;373;0;357;0
WireConnection;373;1;374;0
WireConnection;374;0;372;3
WireConnection;374;1;372;4
WireConnection;371;0;319;0
WireConnection;305;0;306;0
WireConnection;377;0;343;0
WireConnection;377;1;378;0
WireConnection;377;2;376;0
WireConnection;375;0;377;0
ASEEND*/
//CHKSM=F99A03D6F355B251A731A8AEA4A4C1C7F4F7AD4A