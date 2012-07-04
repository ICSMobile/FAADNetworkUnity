using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System.Collections.Generic;
using LitJson;
using MiniJSON;

public class CInterface : MonoBehaviour {

	// Use this for initialization
	void Start () {
		FAADUnityNetwork.SetCallbackGameObject("CInterface");
		FAADUnityNetwork.ConnectWithIntegrationKeyAndSecretKey("ihxmkq4Rll","pDGHvIX1CL");
	}
	
	// Update is called once per frame
	void OnGUI () {
		GUIStyle _faadLabel  = new GUIStyle();
		_faadLabel.alignment = TextAnchor.MiddleCenter;
		_faadLabel.normal.textColor = Color.white;
		
		float _ButtonSpaceSize = 50;
		float _defaultSpace = 150;
		float _buttonWidth = 250;
		float _buttonHeight = 50;
		float _fontSize = 15;
		float _defaultCenter = Screen.width / 2;
	
		GUI.Label(new Rect(_defaultCenter - 200, _defaultSpace, 400, 25), "FAAD Network Sample App", _faadLabel);
		
		_defaultSpace += _fontSize + 10;
		
		if (GUI.Button(new Rect(_defaultCenter - (_buttonWidth / 2), _defaultSpace, _buttonWidth, _buttonHeight), "Show Portrait Ads"))
		{
			FAADUnityNetwork.DisplayPortraitAds();
		}
		
		_defaultSpace += _ButtonSpaceSize;
		
		if (GUI.Button(new Rect(_defaultCenter - (_buttonWidth / 2), _defaultSpace, _buttonWidth, _buttonHeight), "Show Landscape Ads"))
		{
			FAADUnityNetwork.DisplayLandScapeAds();
		}
		_defaultSpace += _ButtonSpaceSize;
		
		if (GUI.Button(new Rect(_defaultCenter - (_buttonWidth / 2), _defaultSpace, _buttonWidth, _buttonHeight), "Get Key Value Pairs"))
		{
			FAADUnityNetwork.GetKeyValuePairsForGameObject("CInterface","keyValuePairsReceivedInKit");
		}
	}
	
	
	public  void keyValuePairsReceivedInKit(string jsonString){
		print(jsonString);
		print("JsonString printer");
		var dic = Json.Deserialize(jsonString) as Dictionary<string,object>;
		print("The AppTitle is: " + (string) dic["AppMessageTitle"]);
		
		
		
	}
	
	
	public void FAADConnected(){
	
			print("FAADConnected Received in unity");
	}

	public void FAADFeedViewClosed(){
		
		print ("FAADView is Closed in unity");

	}
}
