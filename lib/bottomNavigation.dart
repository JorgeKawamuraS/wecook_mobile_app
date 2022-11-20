import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wecookmobile/home.dart';
import 'package:wecookmobile/login.dart';
import 'package:wecookmobile/search_recipe.dart';
import 'package:wecookmobile/create_recipe.dart';
import 'package:wecookmobile/profile.dart';
import 'globals.dart' as globals;
import 'package:wecookmobile/helpers/chip_model.dart';

class bottomNavigation extends StatefulWidget {
  //const bottomNavigation({Key? key}) : super(key: key);

 // int r;
  List<ChipModel> chips;

  bottomNavigation({required this.chips});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {

  int _paginaActual=0;
  List<Widget> _paginas =[
    home(),
    SearchRecipe(chips: [],),
    CreateRecipeScreen(),
    globals.isLoggedIn ? ProfileScreen() : login(),
  ];

  late List<ChipModel> ing;

  //late List<Widget> _paginas;

  @override
  void initState() {
    super.initState();
    _paginaActual = globals.idNavigation;

    ing = widget.chips;

    inspect(ing);

    _paginas =[
      //home(),
      CreateRecipeScreen(),
      SearchRecipe(chips: ing),
      CreateRecipeScreen(),
      globals.isLoggedIn ? ProfileScreen() : login(),
    ];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap:(index){
          setState(() {
            _paginaActual=index;
          });
        },
        currentIndex: _paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label:"Buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline),label:"Agregar Receta"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:"Mi Cuenta")
        ],

      ),

    );
  }
}
