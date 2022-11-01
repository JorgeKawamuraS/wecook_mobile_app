import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({ Key? key }) : super(key: key);

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {

  final ImagePicker picker = ImagePicker();
  var imagen;
  int photo = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            const Text("VERIFICAR MI IDENTIDAD", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.center),

            const SizedBox(
              height: 30,
            ),

            TextFormField(
              keyboardType: TextInputType.text,
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

            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'APELLIDOS',
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
                      child: Text('ADJUNTAR FOTO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              imagen == null ? Center() : Image.file(imagen, height: 200),                         

            const SizedBox(
            height: 30,
            ),
          
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {        
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('VALIDAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
      
    );
  }
}