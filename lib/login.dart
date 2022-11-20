import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wecookmobile/api/user.dart';
import 'package:wecookmobile/bottomNavigation.dart';
import 'register.dart';
import 'globals.dart' as globals;
import 'home.dart';
import 'package:wecookmobile/api/service.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Future<User>? _futureAlbum;
  late int _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC44C04),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),

              Text('Iniciar Sesión',style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 32, color: Colors.white,
              ),),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //borderRadius: BorderRadius.circular(15),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border:InputBorder.none,
                        hintText: 'Usuario',
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //borderRadius: BorderRadius.circular(15),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border:InputBorder.none,
                        hintText: 'Contraseña',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            _user= await service.login(_email.text,_password.text);
                            log('user: $_user');
                            setState(() {
                              //log('result: $_user');
                            });
                            if(_user!=0){
                              globals.idProfileLogged=_user;
                              globals.isLoggedIn = true;
                              globals.idNavigation = 0;
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>bottomNavigation(chips: [],)));
                            }
                            else{
                              log('no login');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Contraseña incorrecta")));
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("Ingresar",style:TextStyle(
                              //fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿No tienes una cuenta? ", style: TextStyle(
                    color: Colors.white,
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>register()));
                    },
                    child: Text("Regístrate", style: TextStyle(
                      fontWeight: FontWeight.bold,color:Colors.white,
                    ),),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
