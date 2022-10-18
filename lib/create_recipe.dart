import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  bool value = false;

  List<Widget> listIngredients = [];
  List<Widget> listSteps = [];
  
  final ImagePicker picker = ImagePicker();
  final ImagePicker pickerS = ImagePicker();
  var imagen;
  String img = "";
  int photo = 0;
  
  var namePhoto;
  int photoS =  0;
  var imagenS;

  @override
  void initState() {
    super.initState();
    
    listIngredients.addAll([
      Text("INGREDIENTE ${ (listIngredients.length/4 + 1).toStringAsFixed(0) }", style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Ingrediente',
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                ))),
        style: const TextStyle(color: Colors.black),
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Calorías',
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                ))),
        style: const TextStyle(color: Colors.black),
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Precio',
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                ))),
        style: const TextStyle(color: Colors.black),
      ),
    ]);
    listSteps.addAll([
      Column(
        children: [
          Text("PASO ${ (listSteps.length/2 + 1).toStringAsFixed(0) }", style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          
          InkWell(
            onTap: () {
              opcionesS(context);
            },
            child: Container(                     
              padding: const EdgeInsets.all(20),  
              color: Colors.brown[200],                                            
              child: Row(
                children: const [
                  Expanded(
                    child: Text('ADJUNTAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  Icon(Icons.camera_alt, color: Colors.white)
                ],
              ),
            ),
          ),
        ]
      ),

      TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Preparación',
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.brown,
                ))),
        style: const TextStyle(color: Colors.black),
      ),
    ]);

  }

  Future selImagen(op) async {

    try {
      var pickerFile;

      if (op == 1) {
        pickerFile = await picker.pickImage(source: ImageSource.camera);
      } else {
        pickerFile = await picker.pickImage(source: ImageSource.gallery);
      }

      if (pickerFile != null) {
        imagen = File(pickerFile.path);
        //namePhoto = pickerFile.path.toString().substring(38);
        // img = pickerFile.path;
        // print("Slida "+ img);

        // File imgFile = File(img);
        // Uint8List imgBytes = await imgFile.readAsBytes();
        // base64string = base64.encode(imgBytes);

        setState(() {

        });

      } else {
        print('No seleccionaste ninguna foto');
      }

      Navigator.of(context).pop();

    } catch (e) {
      print("Error while picking file");
    }
  }

  opciones(context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      photo = 1;
                      selImagen(1);
                      setState((){

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Tomar una foto', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                          ),
                          Icon(Icons.camera_alt_outlined, color: Colors.brown),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      photo = 1;
                      selImagen(2);
                      setState((){

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Seleccionar una foto', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                          ),
                          Icon(Icons.collections, color: Colors.brown)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.brown,
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Cancelar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      );
    }
  
  Future selImagenS(op) async {

    try {
      var pickerFile;
      if (op == 1) {
        pickerFile = await pickerS.pickImage(source: ImageSource.camera);
      } else {
        pickerFile = await pickerS.pickImage(source: ImageSource.gallery);
      }

      if (pickerFile != null) {
        photoS = 1;
        imagenS = File(pickerFile.path);
        namePhoto = pickerFile.path.toString().substring(50);
        // img = pickerFile.path;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Imagen " + namePhoto.toString() + " se subio exitosamente"),
        ));      

        // File imgFile = File(img);
        // Uint8List imgBytes = await imgFile.readAsBytes();
        // base64string = base64.encode(imgBytes);

        setState(() {
          photoS;
          namePhoto;
        });

      } else {
        print('No seleccionaste ninguna foto');
      }

      Navigator.of(context).pop();

    } catch (e) {
      print("Error while picking file");
    }
  }

  opcionesS(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    //photoS = 1;
                    selImagenS(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Tomar una foto', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                        ),
                        Icon(Icons.camera_alt_outlined, color: Colors.brown),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    selImagenS(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Seleccionar una foto', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                        ),
                        Icon(Icons.collections, color: Colors.brown)
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.brown,
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Cancelar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                // onStepContinue:  continued,
                // onStepCancel: cancel,
                controlsBuilder: (BuildContext context, { VoidCallback? onStepContinue, VoidCallback? onStepCancel }) {
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentStep == 0) {
                              continued1();
                            } else if (_currentStep == 1) {
                              continued2();
                            } else if (_currentStep == 2) {
                              continued3();
                            } else {
                              continued4();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('CONTINUAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentStep == 0) {
                              cancel1();
                            } else if (_currentStep == 1) {
                              cancel2();
                            } else if (_currentStep == 2) {
                              cancel3();
                            } else {
                              cancel4();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('CANCELAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  );
                },

                steps: <Step>[
                  Step(
                    title: const Text('', style: TextStyle(color: Colors.black)),
                    content: Column(
                      children: <Widget>[

                        const Text("CREA TU RECETA", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900)),

                        const SizedBox(
                          height: 30,
                        ),

                        const Text("Información de la receta", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nombre',
                              labelStyle: TextStyle(
                                color: Colors.brown,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown,
                                  ))),
                          style: const TextStyle(color: Colors.black),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Recomendación',
                              labelStyle: TextStyle(
                                color: Colors.brown,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown,
                                  ))),
                          style: const TextStyle(color: Colors.black),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: [
                            Theme(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      value = newValue!;
                                    });
                                  },
                                )),
                                data: ThemeData(
                                  primarySwatch: Colors.brown,
                                  unselectedWidgetColor: Colors.brown, // Your color
                                ),
                              ),

                            const Text("Exclusividad", style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(
                      children: <Widget>[

                        const Text("CREA TU RECETA", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900)),

                        const SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Ingredientes de la receta", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),

                            IconButton(
                                onPressed: (){
                                  listIngredients.addAll([
                                    Text("INGREDIENTE ${ (listIngredients.length/4 + 1).toStringAsFixed(0)}", style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Ingrediente',
                                          labelStyle: TextStyle(
                                            color: Colors.brown,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              ))),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Calorías',
                                          labelStyle: TextStyle(
                                            color: Colors.brown,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              ))),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Precio',
                                          labelStyle: TextStyle(
                                            color: Colors.brown,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.brown,
                                              ))),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ]);

                                  setState(() => listIngredients);
                                },
                                icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
                            ),

                          ],                   
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          height: 300,
                          child: GridView.count(
                            childAspectRatio: 8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 1,
                            children: List.generate(listIngredients.length, (aux) {
                              return Container(
                                child: listIngredients[aux],
                              );
                            }),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(
                      children: <Widget>[

                        const Text("CREA TU RECETA", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900)),

                        const SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Preparación de la receta", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),

                            IconButton(
                              onPressed: (){
                                listSteps.addAll([                                 
                                  Column(
                                    children: [
                                      Text("PASO ${ (listSteps.length/2 + 1).toStringAsFixed(0) }", style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                      
                                      InkWell(
                                        onTap: () {
                                          opcionesS(context);
                                        },
                                        child: Container(                     
                                          padding: const EdgeInsets.all(20),  
                                          color: Colors.brown[200],                                            
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                child: Text('ADJUNTAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              ),
                                              Icon(Icons.camera_alt, color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),                                                               
                                    ]
                                  ),

                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Preparación',
                                        labelStyle: TextStyle(
                                          color: Colors.brown,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.brown,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.brown,
                                            ))),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ]);

                                setState(() => listSteps);
                              },
                              icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          height: 300,
                          child: GridView.count(
                            //shrinkWrap: true,
                            childAspectRatio: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 1,
                            children: List.generate(listSteps.length, (aux) {
                              return Container(
                                child: listSteps[aux],
                              );
                            }),
                          )
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(
                      children: <Widget>[

                        const Text("CREA TU RECETA", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900)),

                        const SizedBox(
                          height: 30,
                        ),

                        const Text("Multimedia de la receta", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),

                        const SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          onTap: () {
                            opciones(context);
                          },
                          child: Container(                     
                            padding: const EdgeInsets.all(20),  
                            color: Colors.brown[200],                                            
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text('ADJUNTAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                Icon(Icons.camera_alt, color: Colors.white)
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        if (photo == 1)                                             
                          imagen == null ? Center() : Image.file(imagen),                         

                        const SizedBox(
                        height: 30,
                        ),


                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 3 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued1(){    
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }

  continued2(){
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }

  continued3(){
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }

  continued4(){
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }

  cancel1(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  cancel2(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  cancel3(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  cancel4(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

}
