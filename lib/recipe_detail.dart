import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wecookmobile/api/comment.dart';
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
  late int _statusCookbook;

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
                  Row(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(this.widget.r.name, style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold )),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff89250A),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),

                                    child: Column(
                                      children: [
                                        Text('Guardar en recetario'),
                                        Divider(
                                            color: Colors.black
                                        ),
                                        Container(
                                          height: 200,
                                          width: 200,
                                          child: FutureBuilder(
                                                initialData: [],
                                                future:service.getCookbookByProfileId(globals.idProfileLogged),
                                                builder: (context, AsyncSnapshot<List> snapshot){
                                                  return  ListView.builder(
                                                      //scrollDirection: Axis.vertical,
                                                      //shrinkWrap: true,
                                                      itemCount:snapshot.data!.length,
                                                      itemBuilder: (context,index){
                                                        var cb=snapshot.data![index];
                                                        return ListTile(
                                                          title: Text(cb.name.toString()),
                                                          onTap: () async {
                                                            log(cb.name.toString());
                                                            if(globals.idProfileLogged!=0){
                                                              _statusCookbook= await service.assignCookbookRecipe(this.widget.r.id, cb.id);
                                                              log(_statusCookbook.toString());
                                                              if(_statusCookbook==201){
                                                                log("clear cookbook");
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                    content: Text("Receta guardada satisfactoriamente.")));
                                                              }
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            }
                                                            else{
                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                content: Text("Inicia sesión para guardar una receta"),
                                                                backgroundColor: Color(0xFFC44C04),
                                                              ));
                                                            }
                                                          },
                                                        );
                                                      });
                                                  // return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                                                  //     shrinkWrap: true,
                                                  //     itemCount: snapshot.data!.length,
                                                  //     itemBuilder: (context,index){
                                                  //       var cookbook=snapshot.data![index];
                                                  //       if(snapshot.hasData){
                                                  //         return GestureDetector(
                                                  //           onTap: (){
                                                  //             //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>recipe_detail(r:recipe,m:image)));
                                                  //           },
                                                  //           child: Card(
                                                  //             color: Color(0xFF89250A),
                                                  //             child: Column(
                                                  //               children: [
                                                  //
                                                  //                 //Image.memory(Base64Decoder().convert(image.url),width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                                  //                 // Image.network(imageD,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                                  //                 SizedBox(height: 7,),
                                                  //                 Text(cookbook.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                                  //               ],
                                                  //             ),
                                                  //
                                                  //           ),
                                                  //         );
                                                  //       }
                                                  //       return Center(child:Text("Loading..."));
                                                  //
                                                  //     });

                                                },
                                              ),
                                        ),
                                      ],
                                    ),



                                ),
                                actions: [
                                  // RaisedButton(
                                  //     child: Text("Aceptar"),
                                  //     onPressed: () async {
                                  //       log(_nameCookbook.text);
                                  //       _status= await service.createCookbook(_nameCookbook.text, globals.idProfileLogged);
                                  //       log(_status.toString());
                                  //       if(_status==201) {
                                  //         log("clear");
                                  //         _nameCookbook.clear();
                                  //       }
                                  //       setState(() {});
                                  //       Navigator.pop(context);
                                  //     }
                                  // )
                                ],
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Guardar",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],),

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
                    itemCount:widget._steps.length,
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
                    future:service.getObjectProfileById(widget.r.profileId),
                    builder: (context, snapshot){

                      if(snapshot.hasData){
                        var profile=snapshot.data!;
                        var imageD=Base64Decoder().convert(profile.profilePictureUrl);
                        return Card(
                          color: Color(0xFF89250A),
                          child: Column(
                            children: [
                              Image.memory(imageD, width: 150,fit:BoxFit.fitWidth,height: 130,),
                              //Image.network(profile.profilePictureUrl,width: 150,fit:BoxFit.fitHeight,height: 130,),
                              SizedBox(height: 7,),
                              Text(profile.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                              SizedBox(height: 7,),
                            ],
                          ),

                        );
                      }
                      else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
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
                            log('idUserD:${globals.idProfileLogged}');
                            if(globals.idProfileLogged!=0){
                              _status= await service.createComment(_comment.text, globals.idProfileLogged, widget.r.id);
                              log(_status.toString());
                              if(_status==201){
                                log("clear");
                                _comment.clear();
                                setState(() {});
                              }
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Inicia sesión para agregar un comentario"),
                                backgroundColor: Color(0xFFC44C04),
                              ));
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
                            Comment comment=snapshot.data![index];
                            log('commentprofileid:${comment.profileId}');
                            return FutureBuilder<Profile>(
                              future:service.getObjectProfileById(comment.profileId),
                              builder: (context, snapshotP){
                                if(snapshotP.hasData){
                                  var profile=snapshotP.data!;
                                  return ListTile(
                                    title: Text(profile.name.toString()),
                                    subtitle: Text(comment.text.toString()),
                                  );
                                }
                                else {
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

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
