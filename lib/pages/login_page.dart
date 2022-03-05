import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_faceid3/pages/home_page.dart';
import 'package:project_faceid3/pages/profile_page.dart';
import 'package:project_faceid3/pages/registration_page.dart';
import 'package:project_faceid3/pages/widgets/header_widget.dart';
import 'package:project_faceid3/pages/widgets/themes_helper.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
static String routeName = "/login";

/*/Initialialize Firebase
  Future<FirebaseApp> _initializeFirebase() async{

    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }*/


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

//editing controller
  final TextEditingController emailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  //Firebase
  final _auth = FirebaseAuth.instance;

  String? errorMessage;


  //void _register() async{}


/*https://www.youtube.com/watch?v=yyD_VqSrKd8*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container for Header Widgets
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),

            //Login's form area
            SafeArea(child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  Text('Hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.0),

                  //Email
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //Email

                            TextFormField(
                              autofocus: false,
                              controller: emailController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Email', 'Enter your email'),
                              // InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('Please enter your email');
                                }
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                            ),

                            //Password
                            SizedBox(height: 30.0),
                            TextFormField(
                              autofocus: false,
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                              },
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Password', 'Enter your password'),
                            ),

                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.topRight,

                              child: Text('Forgot your password'),

                            ),
                            // SizedBox(height: 15.0),

                            //Sign In button
                            Container(
                              decoration: ThemeHelper().buttonDecoration(
                                  context),
                              child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(),
                                        style: TextStyle(fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                  //navigate to the Profile page
                                  onPressed: () {
                                    signIn(emailController.text,
                                        passwordController.text);
                                  }),


                            ),
                            //SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text.rich(
                                  TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Don\'t have an account? "),
                                        TextSpan(text: 'Sign Up',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationPage()));
                                            },
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme
                                                  .of(context)
                                                  .accentColor),


                                        ),
                                      ]
                                  )
                              ),

                            ),


                          ],

                        )),)
                ],
              ),


            )),


          ],
        ),

      ),


    );
  }

  //Login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) =>
        {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProfilePage())),// HomePage())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}

