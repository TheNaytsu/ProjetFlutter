import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged/core/core.dart';
import 'package:miaged/start/inscription.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  void _signIn() async{
    if (_key.currentState!.validate()){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginController.text, password: passwordController.text,);
        setState(() {
          errorMessage = '';
        });
        Navigator.pushAndRemoveUntil( 
        context,
        MaterialPageRoute(builder: (context) => const Core()),  
          (Route<dynamic> route) => false,
          );
      } on FirebaseAuthException catch (error) {      
        setState(() {
          errorMessage = error.message!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    const TextStyle textStyle = TextStyle(fontSize: 16);
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: textStyle,
      primary: const Color(0xFF5C95A1),
      fixedSize:  const Size(250, 45)
      );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF20445b),
        appBarTheme: const AppBarTheme(
          color : Color(0xFF20445b),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF20445b))
          ),
        )
      ),
      home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Miaged',style: TextStyle(fontFamily: 'bebaskai', fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child:
          Form(
            key : _key,
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 45.0),
                      TextFormField(
                        style : textStyle,
                        controller : loginController,
                        validator: loginValidator,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Login"
                        )
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        style : textStyle,
                        controller : passwordController,
                        validator: passwordValidator,
                        obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password"
                        )
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),

                      Text(errorMessage),

                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: _signIn,
                        child: const Text('Se connecter'),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.push( 
                            context,
                            MaterialPageRoute(builder: (context) => const Inscription()), 
                            );
                        },
                        child: const Text('S\'inscrire'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    )
    ));
  }
}

String? loginValidator(String? loginForm) {
  if(loginForm == null || loginForm.isEmpty){
    return 'Vous devez indiquer votre login.';
  }
  return null;
}
String? passwordValidator(String? passwordForm) {
  if(passwordForm == null || passwordForm.isEmpty){
    return 'Vous devez indiquer votre mot de passe.';
  }
  RegExp letterReg = RegExp(r".[A-Za-z].");
  if (!letterReg.hasMatch(passwordForm)) {
    return 'Votre mot de passe doit contenir au moins une lettre';
  }
  return null;
}
String? birthdateValidator(String? birthdateForm) {
  if(birthdateForm == null || birthdateForm.isEmpty){
    return 'Vous devez donner une date d\'anniversaire.';
  }
  return null;
}
String? addressValidator(String? addressForm) {
  if(addressForm == null || addressForm.isEmpty){
    return 'Vous devez donner votre adresse.';
  }
  return null;
}
String? postalcodeValidator(String? postalcodeForm) {
  if(postalcodeForm == null || postalcodeForm.isEmpty){
    return 'Vous devez donner votre code postal.';
  }
  return null;
}
String? townValidator(String? townForm) {
  if(townForm == null || townForm.isEmpty){
    return 'Vous devez indiquer une ville.';
  }
  return null;
}
