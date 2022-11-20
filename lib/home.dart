import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';
import 'api/multimedia.dart';
import 'api/profile.dart';
import 'recipe_detail.dart';
import 'globals.dart' as globals;
import 'dart:convert';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("HOME");
    print(globals.userId);

    print(globals.isLoggedIn);

    globals.isLoggedIn? print("pepe1"): print("pepes");

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Últimas recetas",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ),
              FutureBuilder(
                    initialData: [],
                    future:service.getRecipe(),
                    builder: (context, AsyncSnapshot<List> snapshot){
                      return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            var recipe=snapshot.data![index];
                           // var image=service.getMultimediaByRecipeId(recipe.id);
                            //var recipe=recipes[index];
                            if(snapshot.hasData){
                              return FutureBuilder<Multimedia>(
                                future:service.getMultimediaByRecipeId(recipe.id),
                                builder: (context,snapshotMultimedia){
                                  //var imageD=Base64Decoder().convert(image.url);
                                  if (snapshotMultimedia.hasData){
                                    var image=snapshotMultimedia.data!;
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>recipe_detail(r:recipe,m:image)));
                                      },
                                      child: Card(
                                        color: Color(0xFF89250A),
                                        child: Column(
                                          children: [

                                            Image.memory(Base64Decoder().convert(image.url),width: double.infinity,fit:BoxFit.fill,height: 130,),
                                            // Image.network(imageD,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
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


                                  }



                              );
                            }
                            return Center(child:Text("Loading..."));

                          });

                    },
                  ),

              SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Chefs más populares",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ),

              FutureBuilder(
                initialData: [],
                future:service.getProfile(),
                builder: (context, AsyncSnapshot<List> snapshot){
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                     // itemCount: 2,
                      itemBuilder: (context,index){
                    if(snapshot.hasData){
                      Profile profile=snapshot.data![index];
                      //var recipe=users[index];
                      return index<2 ?
                      Card(
                        color: Color(0xFF89250A),
                        child: Column(
                          children: [
                            Image.memory(Base64Decoder().convert(profile.profilePictureUrl),width: double.infinity,fit:BoxFit.fitWidth,height: 130,),
                            // Image.network(profile.profilePictureUrl,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                            SizedBox(height: 10,),
                            Text(profile.name.toString(),style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      )
                          :
                      Container();
                    }
                    else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                      });

                },
              ),
              // FutureBuilder(
              //       initialData: [],
              //       future:service.getRecipe(),
              //       builder: (context, AsyncSnapshot<List> snapshot){
              //         return Transform.scale(
              //           alignment: FractionalOffset.topCenter,
              //           scale: 0.4,
              //           child: ScaledList(
              //             itemCount: categories.length,
              //             itemColor: (index) {
              //               return kMixedColors[index % kMixedColors.length];
              //             },
              //             itemBuilder: (index,selectedIndex){
              //               final category = categories[index];
              //               return Column(
              //
              //                 children: [
              //                   Container(
              //
              //                     height: selectedIndex == index
              //                         ? 200
              //                         : 150,
              //
              //                       child: FittedBox(
              //                         fit: BoxFit.fill,
              //                           child: ClipRRect(
              //                               borderRadius: BorderRadius.circular(6),
              //                               child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOjrcB7S_KmVCgLUB80RUCosy2GqgtrP-IyA&usqp=CAU',height: 100,))),
              //
              //
              //                   ),
              //                   SizedBox(height: 15),
              //                   Text(
              //                     category.name,
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 15),
              //                   )
              //                 ],
              //               );
              //             },
              //           ),
              //         );
              //
              //       },
              //     ),



            ],
          )
        ),
      ),

    );
  }



}

final List<Color> kMixedColors = [
  Color(0xff962D17),
];

final List<Recipe> recipes = [
  Recipe(image: "assets/images/1.png", name: "Receta 1"),
  Recipe(image: "assets/images/2.png", name: "Receta 2"),
  Recipe(image: "assets/images/3.png", name: "Receta 3"),
  Recipe(image: "assets/images/4.png", name: "Receta 4"),
  Recipe(image: "assets/images/5.png", name: "Receta 5"),
];


class Recipe {
  final String image;
  final String name;

  Recipe({required this.image, required this.name});
}

// final List<User> users = [
//   User(image: "assets/images/1.png", name: "John Doe"),
//   User(image: "assets/images/2.png", name: "John Doe"),
//   User(image: "assets/images/3.png", name: "John Doe"),
//   User(image: "assets/images/4.png", name: "John Doe"),
//   User(image: "assets/images/5.png", name: "John Doe"),
// ];



// class User {
//   final String image;
//   final String name;
//
//   User({required this.image, required this.name});
// }
