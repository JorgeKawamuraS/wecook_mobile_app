import 'package:flutter/material.dart';
import 'api/profile.dart';
import 'api/recipe.dart';
import 'package:wecookmobile/api/service.dart';

class recipe_detail extends StatefulWidget {

  Recipe r;

  late String preparation;
  late List <String> _steps;

  recipe_detail({required this.r});

  @override
  State<recipe_detail> createState() => _recipe_detailState();
}

class _recipe_detailState extends State<recipe_detail> {


  @override
  void initState() {
    super.initState();
    print("aaaa");
    widget.preparation=widget.r.preparation;
    widget._steps=widget.preparation.split(".");
    ///late String preparation=widget.r.preparation;
    // print(preparation);
    // late List <String> _steps=preparation.split(".");
    print(widget._steps);
    print(widget._steps.length);
    print(widget._steps[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Detalle de Receta")
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Image.network('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/12/9/0/FNK_Cheesecake_s4x3.jpg.rend.hgtvcom.616.462.suffix/1387411272847.jpeg',width: double.infinity,fit:BoxFit.fitHeight,),

            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(this.widget.r.name, style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold )),
                  ),
                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Ingredientes", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold )),
                  ),
                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Instrucciones", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold )),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:3,
                      itemBuilder: (context,index){
                      var step=widget._steps[index];
                      var i=index+1;
                      return ListTile(
                        title: Text('$i. '+ step.toString()),
                      );
                      }),

                  Divider(
                      color: Colors.black
                  ),
                  SizedBox(height: 20,),
                  Text("Publicado por", style: TextStyle(fontSize: 20)),

                  SizedBox(height: 10,),

                  FutureBuilder<Profile>(
                    future:service.getProfileById(),
                    builder: (context, snapshot){
                      var profile=snapshot.data!;
                      return Card(
                        color: Color(0xFF89250A),
                        child: Column(
                          children: [
                            Image.network(profile.profilePictureUrl,width: 150,fit:BoxFit.fitHeight,height: 130,),
                            SizedBox(height: 7,),
                            Text(profile.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                            SizedBox(height: 7,),
                          ],
                        ),

                      );

                    },
                  ),
                  SizedBox(height: 20,),
                  Divider(
                      color: Colors.black
                  ),

                  SizedBox(height: 30,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Comentarios", style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 15,),

                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Agrega un Comentario',
                      suffixIcon:Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
