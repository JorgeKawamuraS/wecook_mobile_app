import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api/multimedia.dart';
import 'api/recipe.dart';
import 'filter.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';
import 'recipe_detail.dart';
import 'package:wecookmobile/helpers/chip_model.dart';

class SearchRecipe extends StatefulWidget {
 // const SearchRecipe({Key? key}) : super(key: key);

  List<ChipModel> chips;

  SearchRecipe({required this.chips});



  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {

  final searchValue=TextEditingController();

  late bool _IsSearching;
  String searchString = "";

  late List<ChipModel> ingredients;

  late Future<List<Recipe>> _recipes;
  List<Recipe> _recipesFiltered=[];


  @override
  void initState() {
    super.initState();
    _recipes=service.getRecipe();
    _IsSearching = false;
    ingredients=widget.chips;
    print("ingredientes");
    inspect(ingredients);

  }

  void filterRecipe(String value){
    _recipesFiltered.clear();
    setState(() {
      searchString=value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: searchValue,
                  onChanged: (value){

                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Buscar una receta',
                      suffixIcon:IconButton(
                          icon: Icon(
                            Icons.search,
                          ), 
                        onPressed: () { filterRecipe(searchValue.text); },)
                  ),
                ),

                SizedBox(height: 20,),
                Divider(
                    color: Colors.black
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text("Filtros",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      IconButton(
                        onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>filter(chips: ingredients)));
                          },
                        icon: const Icon(Icons.filter_list_alt,
                          size: 25,
                          color: Colors.black
                      ),)
                    ],
                  )
                ),


                FutureBuilder<List>(
                  future:_recipes,
                  builder: (context, AsyncSnapshot<List> snapshot){

                    if(snapshot.hasData){
                      if(ingredients.length>0){
                        log("entro ingredients");
                        log("ing:${ingredients[0]}");
                        for(var i=0; i<snapshot.data!.length;i++){
                          var recipe=snapshot.data![i];
                          if(recipe.name.toLowerCase().contains(ingredients[0].name.toLowerCase())){
                            log("igual3");
                            _recipesFiltered.add(recipe);
                          }
                        }
                        // for(var i=0; i<snapshot.data!.length;i++){
                        //   var recipe=snapshot.data![i];
                        //   for(var j=0; j<ingredients.length;j++){
                        //     if(recipe.name.toLowerCase().contains(ingredients[j].name.toLowerCase())){
                        //       _recipesFiltered.add(recipe);
                        //     }
                        //   }
                        //
                        // }
                      }
                      else if(searchString==""){
                        for(var i=0; i<snapshot.data!.length;i++){
                          log("iniciando");
                          var recipe=snapshot.data![i];
                          _recipesFiltered.add(recipe);
                        }
                      }
                      else {
                        for(var i=0; i<snapshot.data!.length;i++){
                          var recipe=snapshot.data![i];
                          if(recipe.name.toLowerCase().contains(searchString.toLowerCase())){
                            log("igual3");
                            _recipesFiltered.add(recipe);
                          }
                        }
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              itemCount: _recipesFiltered.length,
                              itemBuilder: (context,index){
                                var recipe=_recipesFiltered[index];
                                log('filtered:${_recipesFiltered.length}');
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
                                // return recipe.name.toLowerCase().contains(searchString.toLowerCase())?
                                //  GestureDetector(
                                //   onTap: (){
                                //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>recipe_detail(r:recipe)));
                                //   },
                                //   child: Card(
                                //     color: Color(0xFF89250A),
                                //     child: Column(
                                //       children: [
                                //
                                //         Image.network('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/12/9/0/FNK_Cheesecake_s4x3.jpg.rend.hgtvcom.616.462.suffix/1387411272847.jpeg',width: double.infinity,fit:BoxFit.fitHeight,height: 120,),
                                //         SizedBox(height: 7,),
                                //         Text(recipe.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                //       ],
                                //     ),
                                //
                                //   ),
                                // )
                                //  : Container();


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

  // List<Model> _buildSearchList() {
  //   if (searchString.isEmpty) {
  //     return _searchList = _list;
  //   } else {
  //     _searchList = _list
  //         .where((element) =>
  //     element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
  //         element.title.toLowerCase().contains(_searchText.toLowerCase()))
  //         .toList();
  //     print('${_searchList.length}');
  //     return _searchList;
  //   }
  // }

}


final List<Color> kMixedColors = [
  Color(0xff962D17),
];

// final List<Recipe> recipes = [
//   Recipe(image: "assets/images/1.png", name: "Receta 1"),
//   Recipe(image: "assets/images/2.png", name: "Receta 2"),
//   Recipe(image: "assets/images/3.png", name: "Receta 3"),
//   Recipe(image: "assets/images/4.png", name: "Receta 4"),
//   Recipe(image: "assets/images/5.png", name: "Receta 5"),
//   Recipe(image: "assets/images/5.png", name: "Receta 6"),
//   Recipe(image: "assets/images/5.png", name: "Receta 7"),
//   Recipe(image: "assets/images/5.png", name: "Receta 8"),
//   Recipe(image: "assets/images/5.png", name: "Receta 9"),
//
// ];
//
//
//
// class Recipe {
//   final String image;
//   final String name;
//
//   Recipe({required this.image, required this.name});
// }
