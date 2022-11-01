import 'package:flutter/material.dart';
import 'login.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);


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

              Text('Crea tu cuenta',style: TextStyle(
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
                        hintText: 'Nombre',
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
                        hintText: 'Correo',
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
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("Registrarse",style:TextStyle(
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
                  Text("¿Ya tienes una cuenta? ", style: TextStyle(
                    color: Colors.white,
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
                    },
                    child: Text("Inicia Sesión", style: TextStyle(
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
