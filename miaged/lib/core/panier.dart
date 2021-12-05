import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Panier extends StatefulWidget {
  const Panier({ Key? key }) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: textStyle, primary: const Color(0xFF5C95A1));
    
    return Column(children: [
    Expanded(
    child : StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('Panier')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('Loading'));
        }
        num totalPanier = 0;
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: snapshot.data!.docs.map((panier) {
                  totalPanier += panier['Price'];
                  return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Image.network(panier['Picture']),
                              title: Text(panier['Title']),
                              subtitle: Text('Taille : ' + panier['Size'] +'\nPrix : ' + panier['Price'].toString() +' €'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ElevatedButton(
                                  child: const Text('X'),
                                  style: style,
                                  onPressed: () {
                                    totalPanier -= panier['Price'];
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString())
                                        .collection('Panier')
                                        .doc(panier.id)
                                        .delete();
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                                  height: 10,
                                )
                          ],
                        ),
                      )
                  );
                }).toList(),
              ),
            ),
            Text("Somme totale : " + totalPanier.toString()+' €', style:const TextStyle(fontSize: 18)),
            const SizedBox(
                  height: 55.0,
                )
          ],
        );
        }))]);

  }
}