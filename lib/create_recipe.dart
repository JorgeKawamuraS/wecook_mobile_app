import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecookmobile/bottomNavigation.dart';
import 'api/ingredient.dart';
import 'globals.dart' as globals;
import 'package:wecookmobile/api/service.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:http/http.dart' as http;

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController recommendationController = TextEditingController();
  late TextEditingController ingredientController = TextEditingController();

  List<Ingredient> ingredients = [];
  // List<String> listNamesIngredients = [];
  
  List<String> listIngredientsAdded = [];
  Map<int, String> mapNamesIngredients = {};
  Map<int, String> mapIngredientsAdded = {};

  late final Future _future;

  String label = "Ingredientes";

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  bool exclusiveness = false;

  List<Widget> listSteps = [];
  List<TextEditingController> listStepsControllers = [];
  String preparation = '';
  
  final ImagePicker picker = ImagePicker();
  var imagen;
  String img = "";
  int photo = 0;
  String base64string = "";

  late bool isLogged = false;

  @override
  void initState() {
    super.initState();

    isLogged = globals.isLoggedIn;
    print("ID LOGGED " + isLogged.toString());
    print("ID LOGGED " + globals.idProfileLogged.toString());
    _future = service.getAllIngredients();
    _future.then((value) => {
      //ingredients = value,
      for( var i = 0; i < value.length; i++ ) { 
        ingredients.add(value[i]),
        mapNamesIngredients[value[i].id] = value[i].name,
        //listNamesIngredients.add(value[i].name),
      },

      print('ALL INGREDIENTS ' + ingredients[0].price.toString()),
      print('ALL INGREDIENTS ' + mapNamesIngredients[0]!),
    });

    ingredientController.text = '';

    listStepsControllers.add(TextEditingController());

    listSteps.add( TextFormField(
        controller: listStepsControllers[0],
        keyboardType: TextInputType.text,
        maxLines: 2,
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
    );
    
  }

  createMultimedia(String photo, int recipeId) async {
    var jsonResponse = null;
    Uri myUri = Uri.parse("http://ec2-18-207-219-161.compute-1.amazonaws.com:8093/recipes/$recipeId/multimedia");

    var response = await http.post(myUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
        'url': photo
      }),
    );

    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        print('EXITOSO');
      }
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error al crear multimedia"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  assignIngredients(int recipeId, int ingredientId) async {
    var jsonResponse = null;
    Uri myUri = Uri.parse("http://ec2-18-207-219-161.compute-1.amazonaws.com:8093/recipes/$recipeId/ingredients/$ingredientId");

    var response = await http.post(myUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
      }),
    );

    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if(jsonResponse != null) {
        print('EXITOSO');
        //var id = jsonResponse['id'];
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Se creo su receta exitosamente"),
        //   backgroundColor: Color(0xFFC44C04),
        // ));
      }
    } else {
      print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error al asignar los ingredientes"),
        backgroundColor: Colors.redAccent,
      ));
    }

  }

  createRecipe(String name, bool exclusive, String preparation, String recommendation) async {
    var jsonResponse = null;
    Uri myUri = Uri.parse("http://ec2-18-207-219-161.compute-1.amazonaws.com:8093/recipes");

    var response = await http.post(myUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'views': 0,
        'exclusive': exclusive,
        'preparation': preparation,
        'recommendation': recommendation,
        'profileId': globals.idProfileLogged,
        'cookbookId': 1
      }),
    );

    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        var recipeId = jsonResponse['id'];
        mapIngredientsAdded.forEach((k,v) => assignIngredients(recipeId, k));
        createMultimedia(base64string, recipeId);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Se creo su receta exitosamente"),
          backgroundColor: Color(0xFFC44C04),
        ));
      }
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error al crear su publicacion"),
        backgroundColor: Colors.redAccent,
      ));
    }
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
        img = pickerFile.path;
        // print("Slida "+ img);

        File imgFile = File(img);
        Uint8List imgBytes = await imgFile.readAsBytes();
        base64string = base64.encode(imgBytes);
        print('BASE   ' + base64string);

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),

      body: isLogged == true ? Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: stepperType,
                  //physics: const ScrollPhysics(),
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
                                ingredientController = TextEditingController();                              
                                continued1();
                                setState(() {
                                  ingredientController;
                                });

                              } else if (_currentStep == 1) {
                                continued2();
                              } else if (_currentStep == 2) {
                                continued3();
                                for (var i = 0; i < listStepsControllers.length; i++) {
                                  if (i > 0){
                                    preparation = preparation + '. ' + listStepsControllers[i].text;
                                  } else {
                                    preparation = listStepsControllers[i].text;
                                  }                                  
                                }
                                print('PREPARATION ' + preparation);
                              } else {
                                continued4();
                                createRecipe(nameController.text, exclusiveness, preparation, recommendationController.text);
                                globals.idNavigation = 0;
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => const bottomNavigation())));
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
                                ingredientController = TextEditingController();
                                cancel3();
                                setState(() {
                                  ingredientController;
                                });
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
                            controller: nameController,
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
                            controller: recommendationController,
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
                                    value: exclusiveness,
                                    onChanged: (newValue) {
                                      setState(() {
                                        exclusiveness = newValue!;
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
                        children: [

                          const Text("CREA TU RECETA", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900)),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text("Ingredientes de la receta", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),

                          Row(
                            children: [

                              Expanded(
                                child: TextFieldSearch(
                                  initialList: mapNamesIngredients.values.toList(), 
                                  label: label, 
                                  controller: ingredientController,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: IconButton(
                                  iconSize: 30,
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.brown,
                                  ),
                                  onPressed: () {
                                    if (ingredientController.text.isNotEmpty) {
                                      listIngredientsAdded.add(ingredientController.text);
                                      // for (var i = 0; i < mapNamesIngredients.length; i++) {
                                      //   if (mapNamesIngredients[i] == ingredientController.text) {
                                      //     mapIngredientsAdded[i] = ingredientController.text;
                                      //     mapNamesIngredients.remove(i);
                                      //     break;
                                      //   }
                                      // }
                                      var key = 0;
                                      mapNamesIngredients.forEach((k,v) => {
                                        if (v == ingredientController.text) {
                                          mapIngredientsAdded[k] = ingredientController.text,
                                          key = k,
                                        }
                                      });
                                      mapNamesIngredients.remove(key);
                                                                            
                                      //listNamesIngredients.removeWhere((item) => item == ingredientController.text);
                                      print(ingredientController.text + 'SIIIIUUUUUUU');
                                      print(mapNamesIngredients.toString());
                                      print(mapIngredientsAdded.toString());
                                      print(listIngredientsAdded.toString());
                                      ingredientController.text = '';
                                      setState(() {
                                        mapNamesIngredients;
                                        mapIngredientsAdded;
                                        listIngredientsAdded;
                                      });
                                    } else {
                                      print('No seleccionando');
                                    }
                                    
                                  },
                                ),
                              ),
                      
                            ],
                          ),
                                    
                          const SizedBox(
                            height: 30,
                          ),

                          mapIngredientsAdded.isNotEmpty ? Row(children: const [ Text('Ingredientes seleccionados', style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold)) ]) : const Center(),

                          if (mapIngredientsAdded.isNotEmpty)
                            SizedBox(
                              height: 275,
                              child: GridView.count(
                                childAspectRatio: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                crossAxisCount: 3,
                                children: List.generate(listIngredientsAdded.length, (aux) {
                                  return Container(
                                    child: FlatButton(
                                      child: Text(listIngredientsAdded[aux], style: const TextStyle( fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                      shape: RoundedRectangleBorder( //<-- SEE HERE
                                        side: const BorderSide(
                                          color: Colors.brown,
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      color: Colors.brown[100],
                                      onPressed: (){
                                        print('DESELECCIONAR: ' + listIngredientsAdded[aux]);
                                        
                                        print('List ADD ' + listIngredientsAdded.toString());
                                        var key = 0;
                                        //print('AQUI' + listIngredientsAdded[aux]); 
                                        mapIngredientsAdded.forEach((k,v) {
                                          if ( v == listIngredientsAdded[aux]) {
                                            key = k;
                                          }
                                        });                                  
                                        // for (var i = 0; i < mapIngredientsAdded.length; i++) {
                                        //   if (mapIngredientsAdded[i] == listIngredientsAdded[aux]) {
                                        //     key = i;
                                        //     break;
                                        //   }
                                        // }
                                        print('SALI' + key.toString());
                                        mapIngredientsAdded.remove(key);
                                        mapNamesIngredients[key] = listIngredientsAdded[aux];
                                        listIngredientsAdded.removeWhere((element) => element == listIngredientsAdded[aux]);

                                        print('MAOP NAME ' + mapNamesIngredients.toString());
                                        print('MAOP ADD ' + mapIngredientsAdded.toString());
                                        print('List ADD ' + listIngredientsAdded.toString());

                                        
                                        setState(() {
                                          listIngredientsAdded;
                                          mapIngredientsAdded;
                                          mapNamesIngredients;
                                        });
                                      },
                                    ),
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

                                  listStepsControllers.add(TextEditingController());

                                  listSteps.add(TextFormField(
                                    controller: listStepsControllers.last,
                                    keyboardType: TextInputType.text,
                                    maxLines: 2,
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
                                  ));
                                
                                  setState(() {
                                    listSteps;
                                  });
                                },
                                icon: const Icon(Icons.add_circle_outline, color: Colors.brown),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 300,
                            child: GridView.count(
                              //shrinkWrap: true,
                              childAspectRatio: 5,
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
      ) : 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
        child: Card(
          shape: RoundedRectangleBorder( //<-- SEE HERE
            side: const BorderSide(
              color: Colors.brown,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Image.network('https://s3.amazonaws.com/libapps/accounts/42565/images/ilustracion-acceso.jpg'),

              const ListTile(
                title: Text('NO PUEDE ACCEDER'),
                subtitle: Text('Necesita Iniciar Sesión para crear una receta'),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown)),
                    onPressed: () {
                      globals.idNavigation = 3;
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const bottomNavigation())));
                    },
                  ),
                  const SizedBox(width: 25),
                ],
              ),
            ],
          ),
        ),
      ),
    ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    if (isLogged == true) {
      setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Necesita Iniciar Sesión"),
        backgroundColor: Colors.brown,
      ));
    }
    
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
