FAADNetworkUnity
================

FAADNetwork SDK - Unity version

Integration notes:

Below are the steps to Integrate FAADNetwork in unity projects. 

- Create your Unity Project.

- Create the GameObject on which you want to show FAAD Ads

- In Start method of your game object set the CallbackObject which is used to send notification for FAADConnect and FAAD AdView Closed as follows:

     FAADUnityNetwork.SetCallbackGameObject("FAADInterface");

- Set FAAD Network keys to start the SDK

    FAADUnityNetwork.ConnectWithIntegrationKeyAndSecretKey("Integration Key","Secret Key");

- To Display Landscape Ads call
  
       FAADUnityNetwork.DisplayLandScapeAds();

- To Display Portrait Ads call
         FAADUnityNetwork.DisplayPortraitAds();

-Javascript/C# script controlling FAAD Ads should implement these two methods
        
        function FAADConnected(){
	    print("FAADNetwork Connected");
	}

	function FAADFeedViewClosed(){
		print ("FAAD Feeds View is Closed");
        }

- To use KeyValuePair Webservice. Implement a call back method which should receive a string in which the JSON for KeyValues will be passed as String. Once you have implemented the Call Back method proceed with the following call 

FAADUnityNetwork.GetKeyValuePairsForGameObject("GameObject","CallBackMethod"); 

The GameObject name and CallBackMethod names should be passed a string. CallBackMethod will received the JSON values as a string and the string can be converted to JSON object by using the MiniJSON(open source JSON parser) for C# included with the project or you can use the parser of your own choice.


- Once you have build the project for XCode. To Add the SDK files Right Click on classes folder in Unity-iPhone and Click Add Files..

- Navigate to the Assets->Plugins->FAADiOS and select "SDK" folder add it to the project.

- Make sure that "Create groups for any added folders" is selected

- Add Systemconfiguration Frame work and libsqlite3.0.dylib to your project.

- Build the Project and Run it on Device as UNITY does not runs on simulator (iPhone) while working with native code/plugin

- Set Enable Objective-C Exceptions to YES in your targets build settings.


