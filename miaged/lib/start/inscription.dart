import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/start/login.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  TextStyle textStyle = const TextStyle( fontSize: 14);
  final loginController = TextEditingController();
  final passwordController = TextEditingController();  
  final addressController = TextEditingController();
  final postalcodeController = TextEditingController();
  final townController = TextEditingController();
  final birthdateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';


  void _signUp() async{

      if (_key.currentState!.validate()){
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: loginController.text, password: passwordController.text);
          FirebaseFirestore.instance.collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection('Profil').doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set({
                  'Login': loginController.text,
                  'Password' : passwordController.text ,            
                  'Address' : addressController.text,
                  'Postal code' : postalcodeController.text,
                  'Town' : townController.text,
                  'Birthdate' : birthdateController.text,
          });
        } on FirebaseAuthException catch (error) {
          errorMessage = error.message!;
        }
        showDialog(context: context, builder: (context) {
          return AlertDialog(
                contentTextStyle: textStyle,
                title: const Text('Inscription confirmée'),
                actions : <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(textStyle: textStyle,primary: const Color(0xFF5C95A1),
                          fixedSize:  const Size(250, 45)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Se connecter'),
                      ),
                  )]
              );
        });
    }
  }
  
  @override
  Widget build(BuildContext context){
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: textStyle,
      primary: const Color(0xFF5C95A1),
      fixedSize:  const Size(250, 45)
      );
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color : Color(0xFF20445b),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color:Color(0xFF20445b) ),
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
      body: 
        SingleChildScrollView(
          
          child:Form(
            key : _key,
            child: Center(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                            const SizedBox(
                                  width: 10,
                                ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(textStyle: textStyle, primary: const Color(0xFF5C95A1),
                                fixedSize:  const Size(100, 45)),
                              onPressed: () {
                                Navigator.pop(context);
                                },
                              child: const Text('Retour'),
                            ),
                          ])),
                      const SizedBox(
                                  height: 20,
                                ),
                      
                      TextFormField(
                        style : textStyle,
                        controller : loginController,
                        validator: loginValidator,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Login"
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
                          labelText: "Password"
                        )
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        style : textStyle,
                        controller : addressController,
                        validator: addressValidator,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: 'Adresse'
                        )
                      ),
                      const SizedBox(height: 25.0),
                        TextFormField(
                          style : textStyle,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly],
                          controller : postalcodeController,
                          validator: postalcodeValidator,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: 'Code postal'
                          )
                        ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        style : textStyle,
                        controller : townController,
                        validator: townValidator,
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: 'Ville'
                        )
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        style : textStyle,
                        controller : birthdateController,
                        validator: birthdateValidator,
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: 'Date de naissance'
                        )
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      Text(errorMessage),
                      const SizedBox(
                        height: 35.0,
                      ),
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: _signUp,
                        child: const Text('Inscription'),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ),

      ),
     
      ));
  }
}



