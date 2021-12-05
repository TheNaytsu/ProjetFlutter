import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String id;
  final String title;
  final String picture;
  final String brand;
  final String size;
  final int price;
  const Details({Key? key,required this.id, required this.title, required this.picture, required this.brand, required this.size, required this.price}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {

    @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: textStyle, primary: const Color(0xFF5C95A1),
    fixedSize:  const Size(200, 45));

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color : Color(0xFF20445b),
        ),   
      ),
      home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Miaged',style: TextStyle(fontFamily: 'bebaskai', fontSize: 30)),
      ),
      body:
        Column(
          children: [
            const SizedBox(
                    height: 40,
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
            const SizedBox(height: 40),
            Text(widget.title, style:const TextStyle(fontSize: 18)),      
            const SizedBox(height: 40),        
            Card(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      widget.picture,
                      height: 300,
                      fit:BoxFit.fitHeight  
                    ),
                  ),
                  ListTile(
                    title: const Text('Description du produit : '),
                    subtitle: Text('Marque :  '+ widget.brand +'\nTaille : '+ widget.size +'. \nPrix : ' + widget.price.toString() + ' €.' ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          FirebaseFirestore.instance.collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid.toString()) 
                          .collection('Panier')
                          .doc(widget.id)
                          .set({
                          'Title': widget.title,
                          'Price' : widget.price ,
                          'Brand' : widget.brand,
                          'Picture' : widget.picture,
                          'Size' : widget.size
                        });
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                                contentTextStyle: textStyle,
                                title: const Text('Article ajouté au panier'),
                                actions : <Widget>[
                                    Align(
                                    alignment: Alignment.center,
                                    child:
                                    ElevatedButton(
                                      style: buttonStyle,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Retour'),
                                    )
                                    )]
                              );      
                        }
                        );
                        },
                        child: const Text('Ajouter au panier'),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                        height: 10,
                      ),
                ],
              ),
            )    
          ]),
      )
    );
  }
 }

