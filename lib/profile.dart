import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wecookmobile/api/service.dart';
import 'package:wecookmobile/recipe_detail.dart';
import 'package:wecookmobile/cookbook_recipes.dart';
import 'api/cookbook.dart';
import 'api/multimedia.dart';
import 'api/recipe.dart';
import 'globals.dart' as globals;

import 'api/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameCookbook = TextEditingController();
  late int _status;
  late int _status2;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            FutureBuilder<Profile>(
              future: service.getObjectProfileById(globals.idProfileLogged),
              builder: (context, snapshotP) {
                if (snapshotP.hasData) {
                  var profile = snapshotP.data!;
                  var imageD;
                  imageD = Base64Decoder().convert(profile.profilePictureUrl);

                  return Row(
                    children: [
                      CircleAvatar(
                          radius: (50),
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            // borderRadius:BorderRadius.circular(50),
                            child: Image.memory(
                              imageD,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )),
                      // Container(
                      //   width: 130,
                      //   height: 130,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //         image: Image.memory(imageD),
                      //         //image: NetworkImage('https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=7lrLYx-B'),
                      //         fit: BoxFit.fill
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      //Image.network('https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=7lrLYx-B',width: 150),
                      Column(
                        children: [
                          Text(
                            profile.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("@usuario"),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Lorem ipsum dolor sit amet.",
                              ))
                        ],
                      )
                    ],
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),

            SizedBox(
              height: 30,
            ),
            TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.orange,
              tabs: [
                Tab(
                  text: "Mis Recetas",
                ),
                Tab(
                  text: "Mis Recetarios",
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),

            Expanded(
                child: TabBarView(
              children: [
                FutureBuilder(
                  initialData: [],
                  future: service.getRecipeByProfileId(globals.idProfileLogged),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if(snapshot.hasData)
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var recipe = snapshot.data![index];
                          // var image=service.getMultimediaByRecipeId(recipe.id);
                          //var recipe=recipes[index];
                          return FutureBuilder<Multimedia>(
                            future: service.getMultimediaByRecipeId(recipe.id),
                            builder: (context, snapshotMultimedia) {
                              if(snapshotMultimedia.hasData){
                                var image = snapshotMultimedia.data!;
                                var imageD = Base64Decoder().convert(image.url);
                                log('recipeId:${recipe.id}');
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => recipe_detail(
                                                r: recipe, m: image)));
                                  },
                                  child: Card(
                                    color: Color(0xFF89250A),
                                    child: Column(
                                      children: [
                                        Image.memory(imageD,width: double.infinity,fit:BoxFit.fill,height: 130,),
                                        // Image.network(imageD,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          recipe.name.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                                else {
                                  return Container();
                              }
                            },
                          );
                        });
                    else
                      return Container();
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text('Crea un recetario'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Nombre',
                                                icon: Icon(Icons.edit),
                                              ),
                                              controller: _nameCookbook,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      RaisedButton(
                                          child: Text("Aceptar"),
                                          onPressed: () async {
                                            log(_nameCookbook.text);
                                            _status= await service.createCookbook(_nameCookbook.text, globals.idProfileLogged);
                                            log(_status.toString());
                                            if(_status!=0) {
                                              _status2= await service.createCookbook2(_status);
                                              log("clear");
                                              _nameCookbook.clear();
                                            }
                                             setState(() {});
                                            Navigator.pop(context);
                                          }
                                            )
                                    ],
                                  );
                                });
                          },
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Color(0xFF89250A),// <-- Splash color
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
                      initialData: [],
                      future:service.getCookbookByProfileId(globals.idProfileLogged),
                      builder: (context, AsyncSnapshot<List> snapshot){
                        if(snapshot.hasData)
                          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                            shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){

                              var cookbook=snapshot.data![index];

                                return FutureBuilder<Recipe>(
                                  future:service.getFirstRecipeByCookbookId(cookbook.id),
                                  builder: (context, snapshotRecipes){
                                    if(snapshotRecipes.hasData){
                                      log("hasdata");
                                      inspect(snapshotRecipes);
                                      var recipeFirst=snapshotRecipes.data!;
                                      inspect(recipeFirst);

                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CookbookRecipes(cookbookId:cookbook.id)));
                                        },
                                        child: Card(
                                          color: Color(0xFF89250A),
                                          child: Column(
                                            children: [

                                              Image.memory(Base64Decoder().convert(recipeFirst.multimedia[0].url),width: double.infinity,fit:BoxFit.fill,height: 130,),
                                              // Image.network(imageD,width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                              SizedBox(height: 7,),
                                              Text(cookbook.name.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                                            ],
                                          ),

                                        ),
                                      );

                                    }

                                    else
                                      return Container();

                                  },
                                );

                            });
                        else
                          return Center(child:Text("Crea tu primer recetario"));

                      },
                    ),
                  ],
                )

              ],
              controller: _tabController,
            ))

            // DefaultTabController(length: 2, child: Scaffold(
            //   appBar: AppBar(
            //     bottom: const TabBar(tabs: [
            //       Tab(icon: Icon(Icons.directions_car)),
            //       Tab(icon: Icon(Icons.directions_bike)),
            //     ]),
            //   ),
            //   body: const TabBarView(
            //     children: [
            //       Icon(Icons.directions_car),
            //       Icon(Icons.directions_bike),
            //     ],
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
