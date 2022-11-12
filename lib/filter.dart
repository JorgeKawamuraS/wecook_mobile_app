import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:wecookmobile/api/service.dart';
import 'search_recipe.dart';
import 'bottomNavigation.dart';
import 'package:wecookmobile/helpers/chip_model.dart';

class filter extends StatefulWidget {
  //const filter({Key? key}) : super(key: key);

  List<ChipModel> chips;

  filter({required this.chips});

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  List<ChipModel> _chipList = [];

  @override
  void initState() {
    super.initState();
    _chipList=widget.chips;
  }

  void deleteChips(String id){
    setState(() {
      _chipList.removeWhere((element) => element.id==id);
    });
  }

  static const List<String> _kOptions = <String>[
    'Arroz',
    'Huevo',
    'Pollo',
    'Coliflor',
    'Salmon'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Filtros",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Icon(Icons.filter_list_alt, size: 25, color: Colors.black),
                  ],
                )),
            Divider(color: Colors.black),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Ingredientes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ],
                )),
            SizedBox(
              height: 30,
            ),

            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _kOptions.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    _chipList.add(ChipModel(id: DateTime.now().toString(), name: selection));

                  });
                },
              ),
            ),
            // AutocompleteBasicExample(),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Buscar ingredientes',
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                Wrap(
                  spacing: 10,
                  children: _chipList.map((chip)=>Chip(
                    label: Text(chip.name),
                    onDeleted: (){
                      deleteChips(chip.id);
                    },
                  )).toList(),
                )
              ],
            ),

            Divider(color: Colors.black),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Costo de Preparación",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ],
                )),
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
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            Divider(color: Colors.black),
            SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text("Tiempo de Preparación",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ],
                )),
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
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff89250A),
              ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>bottomNavigation(r: 1,chips: _chipList)));
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Filtrar",
                    style: TextStyle(
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

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'Arroz',
    'Huevo',
    'Pollo',
    'Coliflor',
    'Salmon'
  ];

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          const SizedBox(
            height: 50,
          );
        },
      ),
    );
  }
}


