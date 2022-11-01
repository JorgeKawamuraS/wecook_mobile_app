import 'package:flutter/material.dart';
import 'package:wecookmobile/bottomNavigation.dart';
import 'register.dart';
import 'globals.dart' as globals;
import 'home.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);


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
                          onPressed: (){
                            globals.isLoggedIn = true;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>bottomNavigation()));
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
