import 'package:flutter/material.dart';
import 'package:wecookmobile/home.dart';
import 'package:wecookmobile/login.dart';
import 'package:wecookmobile/create_recipe.dart';

class bottomNavigation extends StatefulWidget {
  const bottomNavigation({Key? key}) : super(key: key);

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {

  int _paginaActual=0;
  List<Widget> _paginas =[
    home(),
    CreateRecipeScreen(),
    CreateRecipeScreen(),
    login(),
  ];

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
