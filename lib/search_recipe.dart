import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filter.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';
import 'recipe_detail.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({Key? key}) : super(key: key);

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {

  final searchValue=TextEditingController();
  String searchString = "";


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
                    setState(() {
                      searchString=value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Buscar una receta',
                    suffixIcon:Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Icons.search,
                      ),
                    ),
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>filter()));
                          },
                        icon: const Icon(Icons.filter_list_alt,
                          size: 25,
                          color: Colors.black
                      ),)
                    ],
                  )
                ),


                FutureBuilder(
                  initialData: [],
                  future:service.getRecipe(),
                  builder: (context, AsyncSnapshot<List> snapshot){
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
                              return recipe.name.toLowerCase().contains(searchString.toLowerCase())?
                               GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>recipe_detail(r:recipe)));
                                },
                                child: Card(
                                  color: Color(0xFF89250A),
                                  child: Column(
                                    children: [

                                      Image.network('https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/12/9/0/FNK_Cheesecake_s4x3.jpg.rend.hgtvcom.616.462.suffix/1387411272847.jpeg',width: double.infinity,fit:BoxFit.fitHeight,height: 120,),
                                      SizedBox(height: 7,),
                                      Text(recipe.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  ),

                                ),
                              )
                               : Container();


                            }),
                      ),
                    );

                  },
                ),

              ],
            ),


      ),

    );
  }
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
