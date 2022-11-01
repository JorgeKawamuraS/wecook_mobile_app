import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';
import 'search_recipe.dart';
import 'bottomNavigation.dart';

class filter extends StatefulWidget {
  const filter({Key? key}) : super(key: key);

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Filtros",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    Icon(Icons.filter_list_alt,
                        size: 25,
                        color: Colors.black
                    ),
                  ],
                )
            ),
            Divider(
                color: Colors.black
            ),
            SizedBox(height: 30,),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Ingredientes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                    ],
                )
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Buscar ingredientes',
              ),
            ),
            SizedBox(height: 30,),
            Divider(
                color: Colors.black
            ),
            SizedBox(height: 30,),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Costo de Preparación",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  ],
                )
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 10,
              activeColor: Color(0xff89250A),
              inactiveColor: Color(0xff89250A),
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values){
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            Divider(
                color: Colors.black
            ),
            SizedBox(height: 30,),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Tiempo de Preparación",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  ],
                )
            ),
            RangeSlider(
              values: _currentRangeValues,
              max: 100,
              divisions: 10,
              activeColor: Color(0xff89250A),
              inactiveColor: Color(0xff89250A),
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values){
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff89250A),
              ),
              onPressed: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>bottomNavigation()));
                },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Filtrar",style:TextStyle(
                  //fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                )),
              ),
            ),

          ],
        ),


      ),

    );
  }
}