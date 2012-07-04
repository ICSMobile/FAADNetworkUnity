using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using LitJson;
	
public class FAADUnityNetwork : MonoBehaviour {
	
	
	public static FAADUnityNetwork sharedInstance_;
	public static string FEEDViewClosedNotificationName = null;
	
	[DllImport("__Internal")]
	private static extern void _setCallbackGameObject(string handlerName);
	
	[DllImport ("__Internal")]
	private static extern void _connectWithIntegrationKeyAndSecretKey(string integrationKey , string secretKey);
	
	
	[DllImport ("__Internal")]
	private static extern void _displayLandScapeAds();
	
	[DllImport ("__Internal")]
	private static extern void _displayPortraitAds();
	
	[DllImport("__Internal")]
	private static extern void _getKeyValuePairsForGameObject(string gameObjectName, string callBack);
	
	public static void SetCallbackGameObject(string handlerName){
		if (Application.platform != RuntimePlatform.OSXEditor){
			print(handlerName);
			_setCallbackGameObject(handlerName);
		}
		
	}
	
	
	public static void ConnectWithIntegrationKeyAndSecretKey(string integrationKey , string secretKey){
		
		if (Application.platform != RuntimePlatform.OSXEditor){
			_connectWithIntegrationKeyAndSecretKey(integrationKey,secretKey);
		}
	}
	
	public static void setNotificationName(string notifyName){
			FEEDViewClosedNotificationName = notifyName;
		
	}
	
	
	public static void DisplayPortraitAds(){
		if (Application.platform != RuntimePlatform.OSXEditor){
		_displayPortraitAds();
		}
	}
	
	public static void DisplayLandScapeAds(){
		if (Application.platform != RuntimePlatform.OSXEditor){
		_displayLandScapeAds();
		}
	}
	
	public static void GetKeyValuePairsForGameObject(string gameObjectName, string callBack){
		if (Application.platform != RuntimePlatform.OSXEditor){
		_getKeyValuePairsForGameObject(gameObjectName,callBack);
		}
		
	} 
	
	// Use this for initialization
	void Start () {
	Debug.Log("FAAD Network", gameObject);
	}
	
	// Update is called once per frame
	void Update () {
	}
	
	public void Awake(){
		FAADUnityNetwork.sharedInstance_ = this;
	}
	
	
	
		
}
