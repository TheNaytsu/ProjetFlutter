import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/details.dart';

class Vetements extends StatefulWidget {
  const Vetements(   { Key? key ,required this.typeClothes}) : super(key: key);
  final String? typeClothes ;
  @override
  _VetementsState createState() => _VetementsState();
}

class _VetementsState extends State<Vetements> {
  TextEditingController searchController = TextEditingController();
@override
  void initState() {
    searchController.addListener(() {
      filtrerListe();
    });
    super.initState();
  }
  filtrerListe(){
    setState(() {
      searchController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle:textStyle, 
      primary: const Color(0xFF5C95A1));

      return Column(children: [
        TextFormField( 
          textAlignVertical: TextAlignVertical.center,
          controller: searchController,
          decoration: const InputDecoration(
            
            prefixIcon: Icon(Icons.search),
            hintText: "Rechercher un vêtement",
            contentPadding: EdgeInsets.only(left: 24.0),
            border: InputBorder.none,
          ),
        ),
         Expanded(
           child :StreamBuilder(    
            stream: FirebaseFirestore.instance
              .collection('Clothes').where('Type', isEqualTo: widget.typeClothes)
              .snapshots(),
            builder : (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) {
                return const Center(child : Text('Loading'));
              }
              return ListView(children : 
              snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> item ) {
                if(item['Title'].toString().trim().toLowerCase().contains(searchController.text.trim().toLowerCase())){
                  return Center(
                  child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Image.network(item['Picture']),
                                title: Text(item['Title']),
                                subtitle: Text('Taille : '+item['Size'] + '\nPrix : ' + item['Price'].toString() + ' €'  ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Détails'),
                                    style : buttonStyle,
                                    onPressed:  () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Details(id: item.id,title:item['Title'],picture:item['Picture'],brand: item['Brand'],size:item['Size'],price:item['Price'])),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              const SizedBox(
                                    height: 10,
                                  )
                            ],
                          ),
                        )
                );
                }
                else{
                  return const SizedBox(height: 0);
                }
              } ).toList()
              );
            }
      ))]);
  
    }
  
 
}