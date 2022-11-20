import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecookmobile/api/multimedia.dart';
import 'package:wecookmobile/recipe_detail.dart';
import 'api/recipe.dart';
import 'globals.dart' as globals;
import 'package:wecookmobile/api/service.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({ Key? key }) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  
  late final Future _future;
  late final Future _future2;
  late final Future _future3;
  late final Future _future4;

  List<int> idRecipes = [];
  late Recipe recipeMC;
  String nameMC = '';
  late Multimedia multimediaMC;
  String urlMC = '';
  Map<int, int> mapComment = {};
  bool data = true;
  int maxComment = -1;

  late Recipe recipeMinC;
  String nameMinC = '';
  late Multimedia multimediaMinC;
  String urlMinC = '';
  int minComment = 999999999;


  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();
  var list;
  var random;

  @override
  void initState() {
    super.initState();
    
    _future = service.getAllRecipesByProfileId(globals.idProfileLogged);
    _future.then((value) => {
      if (value.length > 0) {
        data = true,
        for( var i = 0; i < value.length; i++ ) { 
          idRecipes.add(value[i].id),
          print('IDRECIPE ' + idRecipes.toString()),
          _future2 = service.getComment(value[i].id),
          _future2.then((value2) => {
            print('entra'),
            mapComment[value[i].id] = value2.length,
            if (value2.length > maxComment) {
              _future3 = service.getMultimediaByRecipeId(value[i].id),
              _future3.then((value3) => {
                multimediaMC = value3,
                urlMC = value3.url,
                nameMC = value[i].name,
                maxComment = value2.length,
                recipeMC = value[i],
                random = Random(),
                refreshList(),
                print('RECIPE ' + recipeMC.toString()),
                print('MAP ' + mapComment.toString()),
                print('RESULTTTT   ' + maxComment.toString()),
              })
            },

            if (value2.length < minComment) {
              print('SECONF IF'),
              _future4 = service.getMultimediaByRecipeId(value[i].id),
              _future4.then((value4) => {
                multimediaMinC = value4,
                urlMinC = value4.url,
                nameMinC = value[i].name,
                minComment = value2.length,
                recipeMinC = value[i],
                random = Random(),
                refreshList1(),
                print('RECIPEMIN ' + recipeMinC.toString()),
                //print('MAP ' + mapComment.toString()),
                print('RESULTMIN   ' + minComment.toString()),
              })
            },
          
          }),
        },
      } else {
        data = false, 
        print('NO HAY DATA'),
      }
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });
    return null;
  }

  Future<Null> refreshList1() async {
    refreshKey1.currentState?.show();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });
    return null;
  }

  Uint8List imageFromBase(String photoBase64) {
    var img = base64.decode(photoBase64);
    return img;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

      ),

      body: data == true ? SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
          children: [
            const Text("MIS ESTADISTICAS", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.center),

            const SizedBox(
              height: 30,
            ),    

            const FittedBox(
              fit: BoxFit.fitWidth, 
              child: Text('Mayor número de comentarios', style: TextStyle( fontSize: 24, fontWeight: FontWeight.w600), textAlign: TextAlign.left)
            ),

            (urlMC != '' && nameMC != '') ? RefreshIndicator(
                key: refreshKey,
                child: GestureDetector(
                  onTap: () {
                    print('AQUI  ' + recipeMC.toString());
                    //Navigator.push(context, MaterialPageRoute(builder: ((context) => recipe_detail(r: recipeMC, m: multimediaMC))));
                    //opciones(context);
                  }, // Image tapped
                  child: Column(
                    children: [
                      Image.memory(imageFromBase(urlMC)),

                      Container(
                        color: const Color(0xFFC44C04),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(nameMC, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.left),
                            
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.35,
                            ),

                            const Icon(Icons.comment, color: Colors.white),

                            const SizedBox(
                              width: 10,
                            ),

                            Text(maxComment.toString(), style: const TextStyle( fontSize: 28, fontWeight: FontWeight.w600), textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                    
                    ],
                  )
                  //child: Text(recipeMC.name)
                ),
                onRefresh: refreshList,
              ) : const Center(child: CircularProgressIndicator()),
          
            const SizedBox(
              height: 30,
            ),    

            const FittedBox(
              fit: BoxFit.fitWidth, 
              child: Text('Menor número de comentarios', style: TextStyle( fontSize: 24, fontWeight: FontWeight.w600), textAlign: TextAlign.left)
            ),

            (urlMinC != '' && nameMinC != '') ? RefreshIndicator(
              key: refreshKey1,
              child: GestureDetector(
                onTap: () {
                  print('AQUI  ' + recipeMinC.toString());
                  //Navigator.push(context, MaterialPageRoute(builder: ((context) => recipe_detail(r: recipeMC, m: multimediaMC))));
                  //opciones(context);
                }, // Image tapped
                child: Column(
                  children: [
                    Image.memory(imageFromBase(urlMinC)),

                    Container(
                      color: const Color(0xFFC44C04),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(nameMC, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.normal), textAlign: TextAlign.left),
                          
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.35,
                          ),

                          const Icon(Icons.comment, color: Colors.white),

                          const SizedBox(
                            width: 10,
                          ),

                          Text(minComment.toString(), style: const TextStyle( fontSize: 28, fontWeight: FontWeight.w600), textAlign: TextAlign.right),
                        ],
                      ),
                    ),
                  
                  ],
                )
                //child: Text(recipeMC.name)
              ),
              onRefresh: refreshList1,
            ) : const Center(child: CircularProgressIndicator()),
        
          ]
        ),
      ) : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
        child: Card(
          shape: RoundedRectangleBorder( //<-- SEE HERE
            side: const BorderSide(
              color: Colors.brown,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Image.network('https://s3.amazonaws.com/libapps/accounts/42565/images/ilustracion-acceso.jpg'),

              const ListTile(
                title: Text('NO TIENE RECETAS SUBIDAS'),
                subtitle: Text('Necesita subir recetas para visualizar sus estadísticas', textAlign: TextAlign.justify),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     TextButton(
              //       child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
              //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown)),
              //       onPressed: () {
              //         globals.idNavigation = 3;
              //         //Navigator.push(context, MaterialPageRoute(builder: ((context) => bottomNavigation(chips: [],))));
              //       },
              //     ),
              //     const SizedBox(width: 25),
              //   ],
              // ),
            
            ],
          ),
        ),
      ),
      ),

    

      
    );
  }
}