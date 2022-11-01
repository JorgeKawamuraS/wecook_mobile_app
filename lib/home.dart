import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Últimas recetas",style: TextStyle(fontWeight: FontWeight.bold,)),
            ),
            Flexible(
                child: FutureBuilder(
                  initialData: [],
                  future:service.getRecipe(),
                  builder: (context, AsyncSnapshot<List> snapshot){
                    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing :10 ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          var recipe=snapshot.data![index];
                          return Card(
                            color: Color(0xFF89250A),
                            child: Column(
                              children: [

                                Image.network('https://d1uz88p17r663j.cloudfront.net/original/4a783abdbfe1f7a79fbf5f93139b3c68_Lasagna-de-carne-.jpg',width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                                SizedBox(height: 10,),
                                Text(recipe.name.toString(),style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          );
                        });

                  },
                ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Chefs más populares",style: TextStyle(fontWeight: FontWeight.bold,)),
            ),
            SizedBox(
              child: Flexible(
                child: FutureBuilder(
                  initialData: [],
                  future:service.getRecipe(),
                  builder: (context, AsyncSnapshot<List> snapshot){
                    return Transform.scale(
                      scale: 0.8,
                      child: ScaledList(
                        itemCount: categories.length,
                        itemColor: (index) {
                          return kMixedColors[index % kMixedColors.length];
                        },
                        itemBuilder: (index,selectedIndex){
                          final category = categories[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                child: Image.network('https://d1uz88p17r663j.cloudfront.net/original/4a783abdbfe1f7a79fbf5f93139b3c68_Lasagna-de-carne-.jpg'),

                              ),
                              SizedBox(height: 15),
                              Text(
                                category.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15),
                              )
                            ],
                          );
                        },
                      ),
                    );
                    // return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing :10 ),
                    //     itemCount: snapshot.data!.length,
                    //     itemBuilder: (context,index){
                    //       var recipe=snapshot.data![index];
                    //       return Card(
                    //         color: Color(0xFF89250A),
                    //         child: Column(
                    //           children: [
                    //
                    //             Image.network('https://d1uz88p17r663j.cloudfront.net/original/4a783abdbfe1f7a79fbf5f93139b3c68_Lasagna-de-carne-.jpg',width: double.infinity,fit:BoxFit.fitHeight,height: 130,),
                    //             SizedBox(height: 10,),
                    //             Text(recipe.name.toString(),style: TextStyle(color: Colors.white),),
                    //           ],
                    //         ),
                    //       );
                    //     });

                  },
                ),

              ),
            )

          ],
        )
      ),

    );
  }



}

final List<Color> kMixedColors = [
  Color(0xff962D17),
];

final List<Category> categories = [
  Category(image: "assets/images/1.png", name: "Beef"),
  Category(image: "assets/images/2.png", name: "Chicken"),
  Category(image: "assets/images/3.png", name: "Dessert"),
  Category(image: "assets/images/4.png", name: "Lambb"),
  Category(image: "assets/images/5.png", name: "Pasta"),
];

class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
