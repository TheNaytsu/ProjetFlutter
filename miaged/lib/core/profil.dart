import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/start/login.dart';

class Profil extends StatefulWidget {
  const Profil({ Key? key }) : super(key: key);
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: textStyle,
      primary: const Color(0xFF5C95A1),
      fixedSize:  const Size(250, 45)
      );
    return  Scaffold(
        body : Center(
          child:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('Profil')
            .snapshots(),
          builder : (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return const Center(child : Text('Loading'));
            }
              final _key = GlobalKey<FormState>();
              final loginController = TextEditingController();
              final passwordController = TextEditingController();  
              final addressController = TextEditingController();
              final postalcodeController = TextEditingController();
              final townController = TextEditingController();
              final birthdateController = TextEditingController();
            return ListView(children : snapshot.data!.docs.map((profil ) {
              loginController.text = profil['Login'];
              passwordController.text = profil['Password'];
              addressController.text = profil['Address'];
              postalcodeController.text = profil['Postal code'];
              townController.text = profil['Town'];
              birthdateController.text = profil['Birthdate'];
              return Center(
                child: Form(
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
                              controller : loginController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Login'],
                                labelText: 'Login'
                              )
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller : passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Password'],
                                labelText: 'Password'
                              )
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller : addressController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Address'],
                                labelText: 'Adresse'
                              )
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly],
                              controller : postalcodeController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Postal code'].toString(),
                                labelText: 'Code postal'
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller : townController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Town'],
                                labelText: 'Ville'
                              )
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller : birthdateController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelStyle: const TextStyle(color: Color(0xFF20445b)) ,
                                focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF20445b))),
                                hintText: profil['Birthdate'],
                                labelText: 'Date de naissance'
                              )
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            Text(errorMessage),
                            ElevatedButton(
                              style: buttonStyle,
                              onPressed: (){
                                FirebaseAuth.instance.currentUser!.updatePassword(passwordController.text);
                                FirebaseFirestore.instance.collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                    .collection('Profil')
                                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                    .update({
                                    'Password': passwordController.text,
                                    'Address' : addressController.text,
                                    'Postal code' : postalcodeController.text,
                                    'Town' : townController.text,
                                    'Birthdate' : birthdateController.text
                                    });
                                    errorMessage = 'Modifications enregistrées.';
                              },
                              child: const Text("Valider",textAlign: TextAlign.center)
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ElevatedButton(
                              style: buttonStyle,
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                );
                              },
                              child: const Text("Se déconnecter",textAlign: TextAlign.center),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
              );
            } ).toList(),
            );
          }
          )));
  }
}