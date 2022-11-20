import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'api/multimedia.dart';
import 'api/profile.dart';
import 'api/recipe.dart';
import 'package:wecookmobile/api/service.dart';
import 'globals.dart' as globals;

class recipe_detail extends StatefulWidget {


  Recipe r;
  Multimedia m;

  late String preparation;
  late List <String> _steps;

  recipe_detail({required this.r, required this.m});

  @override
  State<recipe_detail> createState() => _recipe_detailState();
}

class _recipe_detailState extends State<recipe_detail> {

  final TextEditingController _comment = TextEditingController();
  late int _status;

  late final imageD;

  @override
  void initState() {
    super.initState();
    print("aaaa");
    widget.preparation=widget.r.preparation;
    widget._steps=widget.preparation.split(".");
    ///late String preparation=widget.r.preparation;
    // print(preparation);
    // late List <String> _steps=preparation.split(".");
    imageD=Base64Decoder().convert(widget.m.url);
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
           // Image.network(widget.m.url,width: double.infinity,fit:BoxFit.fitHeight,),
            Image.memory(imageD),
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
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:widget.r.ingredients.length,
                      itemBuilder: (context,index){
                        var ing=widget.r.ingredients[index].name;
                        return ListTile(
                          title: Text('\u2022'+' '+ing.toString()),
                        );
                      }),

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
                    future:service.getObjectProfileById(widget.r.id),
                    builder: (context, snapshot){
                      var profile=snapshot.data!;
                      if(snapshot.hasData){
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
                      }
                      else{
                        return Container();
                      }


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
                    controller: _comment,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Agrega un Comentario',
                      suffixIcon:IconButton(
                          onPressed: () async {
                            _status= await service.createComment(_comment.text, globals.userId, widget.r.id);
                            log(_status.toString());
                            if(_status==201){
                              log("clear");
                              _comment.clear();
                              setState(() {});
                            }

                          },
                          icon: Icon(
                            Icons.send,
                          ))
                      // suffixIcon:Align(
                      //   widthFactor: 1.0,
                      //   heightFactor: 1.0,
                      //   child: Icon(
                      //     Icons.send,
                      //   ),
                      // ),
                    ),
                  ),
                  SizedBox(height: 15,),

                  FutureBuilder(
                    initialData: [],
                    future:service.getComment(widget.r.id),
                    builder: (context, AsyncSnapshot<List> snapshot){
                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:snapshot.data!.length,
                          itemBuilder: (context,index){
                            var comment=snapshot.data![index];
                            return FutureBuilder<Profile>(
                              future:service.getProfileById(),
                              builder: (context, snapshot){
                                var profile=snapshot.data!;
                                return ListTile(
                                  title: Text(profile.name.toString()),
                                  subtitle: Text(comment.text.toString()),
                                );
                              },
                            );

                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },);

                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
