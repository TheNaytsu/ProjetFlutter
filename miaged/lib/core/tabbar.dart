import 'package:flutter/material.dart';
import 'package:miaged/vetements/vetements.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({ Key? key }) : super(key: key);

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 14);
    double width = MediaQuery.of(context).size.width;
    double yourWidth = width  / 6;
    return DefaultTabController(
          length: 6,
          child: Column(
            children:  <Widget>[
              
              Material(
                color: const Color(0xFF5C95A1),
                child: TabBar(
                  labelStyle: textStyle ,
                  isScrollable: true,
                  indicatorColor: const Color(0xFF20445b),
                  tabs:  [
                    SizedBox(
                      width: yourWidth,
                      child: const Tab(text:'Tous'),
                    ),
                    SizedBox(
                      width: yourWidth,
                      child: const Tab(text:'Tshirts'),
                    ),
                    SizedBox(
                      width: yourWidth,
                      child: const Tab(text:'Chemises'),
                    ),
                    SizedBox(
                      width: yourWidth*1.5,
                      child: const Tab(text:'Pulls & vestes'),
                    ),
                    SizedBox(
                      width: yourWidth*1.3,
                      child: const Tab(text:'Pantalons'),
                    ),
                    SizedBox(
                      width: yourWidth*1.3,
                      child: const Tab(text:'Accessoires'),
                    ),
                  ],
                )
              ),
              const Expanded(
                flex: 1,
                child: TabBarView(
                  children: [
                    Vetements( typeClothes: null),
                    Vetements( typeClothes: 'Tshirt'),
                    Vetements( typeClothes: 'Chemise'),
                    Vetements( typeClothes: 'Veste'),
                    Vetements( typeClothes: 'Pantalon'),
                    Vetements( typeClothes: 'Accessoire')
                  ],
                ),
              )
            ],
          ));
  }
}

