import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'api/profile.dart';
import 'globals.dart' as globals;
import 'package:wecookmobile/api/service.dart';
import 'package:http/http.dart' as http;

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({ Key? key }) : super(key: key);

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {

  final ImagePicker picker = ImagePicker();
  var imagen;
  int photo = 0;

  final TextEditingController nameController = TextEditingController();
  String gender = 'Seleccionar'; 
  TextEditingController dateController = TextEditingController(); 
  TextEditingController dniController = TextEditingController(); 

  bool controlName = true;  
  var controlGender = null;
  bool controlDni = true;
  bool controlDate = true; 

  late final Future _future;
  late Profile profile;
  String photoBase64 = "";
  bool isEdit = false;
  var pickDate;
  String img = "";
  String base64string = "";
 
  // List of items in our dropdown menu
  var items = [ 
    'Seleccionar',
    'Femenino',
    'Masculino'
  ];

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var list;
  var random;

  @override
  void initState() {
    super.initState();

    _future = service.getObjectProfileById(globals.idProfileLogged);
    _future.then((value) => {
      profile = value,
      nameController.text = value.name,
      if (value.gender != 'Seleccionar') {
        gender = value.gender,
      },
      if (value.birthdate != "0001-01-01T00:00:00.000+00:00") {
        dateController.text = value.birthdate.substring(0,10),
      },
      dniController.text = value.dni.toString(),
      print('AQUIII'),
      photoBase64 = value.profilePictureUrl,
      base64string = value.profilePictureUrl,
      random = Random(),
      refreshList(),
    });
  }

  updateProfile(int profileId, String name, String gender, int dni, String birthdate) async {
    var jsonResponse = null;
    Uri myUri = Uri.parse("${globals.url}profiles/$profileId");

    var response = await http.put(myUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'profilePictureUrl': base64string,
        'gender': gender,
        'birthdate': birthdate,
        'subscribersPrice': profile.subscribersPrice,
        'subsOn': profile.subsOn,
        'tipsOn': profile.tipsOn,
        'dni': dni
      }),
    );

    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        print('Se actualizo el monto');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Se actualizo correctamente"),
          backgroundColor: Color(0xFFC44C04),
        ));
        //Navigator.push(context, MaterialPageRoute(builder: ((context) => const ProfileMenuScreen())));
      }
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error en la actualizacion"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });
    return null;
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
        print("BASE64STRING " + base64string);
        photoBase64 = "";

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

  Uint8List imageFromBase(String photoBase64) {
    var img = base64.decode(photoBase64);
    return img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("MI PERFIL", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
                  IconButton(
                    onPressed: (){
                        controlName = false;  
                        controlGender = 'Si';
                        controlDni = false;
                        controlDate = false; 
                        isEdit = true;
                        setState(() {
                          
                        });
                    },
                    icon: const Icon(Icons.edit, color: Colors.brown),
                  ),
                ],
              ),

             const SizedBox(
                height: 30,
              ),

              photoBase64 != "" ? RefreshIndicator(
                key: refreshKey,
                child: GestureDetector(
                  onTap: () {
                    opciones(context);
                  }, // Image tapped
                  child: Image.memory(imageFromBase(photoBase64))
                ),
                onRefresh: refreshList,
              ) : photo == 0 ? const Center(child: CircularProgressIndicator()) : Center(),

              if (photo == 1)                                             
                imagen == null ? const Center() : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.file(imagen),
                ),                          

              const SizedBox(
                height: 30,
              ),
        
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                readOnly: controlName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NOMBRES',
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
        
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  iconEnabledColor: Colors.brown,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Género',
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
                  value: gender,
                  icon: const Icon(Icons.keyboard_arrow_down),   
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: controlGender == null ? null : 
                  (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  // onChanged: (String? newValue) {
                  //   setState(() {
                  //     gender = newValue!;
                  //   });
                  // },
                ),
              ),
        
              const SizedBox(
                height: 30,
              ),
            
              TextFormField(
                controller: dniController,
                readOnly: controlDni,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DNI',
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
                controller: dateController,
                readOnly: controlDate, //editing controller of this TextField
                decoration: const InputDecoration(                 
                  icon: Icon(Icons.calendar_today, color: Colors.brown), //icon of text field
                  labelText: "Fecha de nacimiento",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.brown,
                  )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.brown,
                  ))
                ),
                onTap: controlDate == false ? () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      locale: const Locale("es", "ES"),
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2050)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate); 
                      pickDate = pickedDate; //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                      //You can format date as per your need

                      setState(() {
                         dateController.text = formattedDate; //set foratted date to TextField value. 
                      });
                  } else {
                      print("Date is not selected");
                  }
                } : (){},
              ),
                      
              // InkWell(
              //   onTap: () {
              //     opciones(context);
              //   },
              //   child: Container(                     
              //     padding: const EdgeInsets.all(20),  
              //     color: Colors.brown[200],                                            
              //     child: Row(
              //       children: const [
              //         Expanded(
              //           child: Text('ADJUNTAR FOTO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              //         ),
              //         Icon(Icons.camera_alt, color: Colors.white)
              //       ],
              //     ),
              //   ),
              // ),
         
              const SizedBox(
                height: 30,
              ),
            
              // if (photo == 1)                                             
              //   imagen == null ? Center() : Image.file(imagen, height: 200),                         
            
              isEdit ? SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {  
                    updateProfile(globals.idProfileLogged, nameController.text, gender, int.parse(dniController.text), dateController.text + 'T00:00:00.000+00:00');      
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('ACTUALIZAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ) : Center(),
            
              isEdit ? const SizedBox(
              height: 30,
              ) : Center(),
            ],
          ),
        ),
      ),
      
    );
  }
}