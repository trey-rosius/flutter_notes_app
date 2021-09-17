import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'package:notes/registration_and_login/reg_login_repo.dart';
import 'package:notes/registration_and_login/register_screen.dart';
import 'package:notes/utils/app_theme.dart';
import 'package:notes/utils/size_config.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in here");

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(create: (_)=>  RegistrationLoginRepo.instance(),
    child: Consumer(builder: (_, RegistrationLoginRepo loginRep,child){
      return Scaffold(

          body: SingleChildScrollView(
            child: Container(
              color: ThemeColor.bgColor,
              height: SizeConfig.screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:EdgeInsets.symmetric(vertical: 20) ,
                    child:  Text("NOTES",
                      style: TextStyle(fontSize: 30,
                          fontFamily: 'SeymourOne',

                          foreground: Paint()..shader = ThemeColor.linearGradient),),),
                  Form(
                      key: _formKey,
                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: Column(
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                controller: loginRep.usernameController,
                                style: TextStyle(color: ThemeColor.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: "Please enter Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: loginRep.passwordController,
                                obscureText: true,
                                style: TextStyle(color: ThemeColor.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color:(Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: 'Please enter a password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),
                            ),

                         loginRep.loading? Container(
                           padding: EdgeInsets.all(10),
                           margin: EdgeInsets.all(20),
                           child: Center(child: CircularProgressIndicator()),
                         ) :   Container(
                              margin: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth,
                              height: 50.toHeight,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                  colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                  tileMode: TileMode.repeated, // repeats the gradient over the canvas
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),

                              ),
                              child: TextButton(

                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginRep.login(context).then((bool isSignedIn){
                                      if(isSignedIn) {
                                        print("signed In");
                                        loginRep.retrieveCurrentUser().then((AuthUser authUser) {
                                          print("user id is"+authUser.userId);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return HomeScreen(authUser.userId);


                                          }));
/*
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            // return RegisterScreen();
                                            //return LoginScreen();

                                            return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                                              child: EditProfileScreen(authUser.userId),);


                                          }));
*/
                                        });




                                      }
                                    });

                                  }
                                },
                                child:Text("Log In",style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(20),
                                width: SizeConfig.screenWidth,
                                height: 50.toHeight,

                                decoration: BoxDecoration(
                                  border: Border.all(color: ThemeColor.secondary,width: 2),

                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),

                                ),
                              child: TextButton(
                                style: ButtonStyle(),
                                  onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  // return RegisterScreen();
                                  //return LoginScreen();

                                  return RegisterScreen();


                                }));
                              }, child: Text("Register",style: TextStyle(fontSize: 20,color: ThemeColor.primary),)),
                            ),




                          ],
                        ),
                      )),
                ],
              ),
            ),
          )
      );
    },),);
  }
}
