import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecookmobile/api/service.dart';
import 'package:wecookmobile/recipe_detail.dart';

import 'api/multimedia.dart';

class CookbookRecipes extends StatefulWidget {

  int cookbookId;

  CookbookRecipes({required this.cookbookId});

  @override
  State<CookbookRecipes> createState() => _CookbookRecipesState();
}

class _CookbookRecipesState extends State<CookbookRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [




            FutureBuilder<List>(
              initialData: [],
              future:service.getRecipesByCookbookId(widget.cookbookId),
              builder: (context, AsyncSnapshot<List> snapshot){

                if(snapshot.hasData){

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            var recipe=snapshot.data![index];
                            return FutureBuilder<Multimedia>(
                              future:service.getMultimediaByRecipeId(recipe.id),
                              builder: (context,snapshotMultimedia){
                                if(snapshotMultimedia.hasData){
                                  var image=snapshotMultimedia.data!;
                                  var imageD=Base64Decoder().convert(image.url);
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>recipe_detail(r:recipe,m:image)));
                                    },
                                    child: Card(
                                      color: Color(0xFF89250A),
                                      child: Column(
                                        children: [
                                          Image.memory(imageD,width: double.infinity,fit:BoxFit.fill,height: 130,),
                                          // Image.network(image.url,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                          SizedBox(height: 7,),
                                          Text(recipe.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                        ],
                                      ),

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
                            );


                          }),
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

          ],
        ),


      ),

    );
  }
}
