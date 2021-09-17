import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';
void main() {

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userId;
  void getUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    setState(() {
      userId = authUser.userId;
    });

  }
  void _configureAmplify() async {

    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    //AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    Amplify.addPlugins([authPlugin,AmplifyAPI()]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
      getUser();

    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _configureAmplify();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(


          primaryColor: Color(0xFF1c1c1c),
          accentColor: Color(0XFFf94c84),
          fontFamily: 'Montserrat'




      ),
        home: HomeScreen(userId),


    );
  }
}

