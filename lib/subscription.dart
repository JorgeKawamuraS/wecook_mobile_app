import 'dart:convert';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecookmobile/api/profile.dart';
import 'globals.dart' as globals;
import 'package:wecookmobile/api/service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({ Key? key }) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  final TextEditingController amountController = new TextEditingController();

  late bool subsOn = false;
  late bool tipsOn = false;
  late double amount = 0;

  late Profile profile;
  late final Future _future;

  @override
  void initState() {
    super.initState();
    
    _future = service.getObjectProfileById(globals.idProfileLogged);
    _future.then((value) => {
      profile = value,
      subsOn = value.subsOn,
      tipsOn = value.tipsOn,
      amount = value.subscribersPrice,
      amountController.text = value.subscribersPrice.toString(),
    });
  }

  updateSubscription(int profileId, double amount, bool subs, bool tips) async {
    var jsonResponse = null;
    Uri myUri = Uri.parse("${globals.url}profiles/$profileId");

    var response = await http.put(myUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
        'name': profile.name,
        'profilePictureUrl': profile.profilePictureUrl,
        'gender': profile.gender,
        'birthdate': profile.birthdate,
        'subscribersPrice': amount,
        'subsOn': subsOn,
        'tipsOn': tipsOn,
        'dni': profile.dni,
        'username': profile.username,
        'description': profile.description
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
        // Navigator.push(context, MaterialPageRoute(builder: ((context) => const ProfileScreen())));
      }
    } else {
      print('Response status: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error en la actualizacion"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("SUSCRIPTORES", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.center),

            const SizedBox(
              height: 60,
            ),

            Row(
              children: const [
                Text("SUSCRIPCION", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            subsOn == true ? TextFormField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: amount > 0 ? amount.toString() : 'Cantidad mínima',
                labelStyle: const TextStyle(
                color: Colors.brown,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                color: Colors.brown,
              )),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                color: Colors.brown,
              ))),
              style: const TextStyle(color: Colors.black),
            ) : Center(),
 
            subsOn == true ? const SizedBox(
              height: 30,
            ) : const Center(),

            Row(
              children: [
                FlutterSwitch(
                  width: 100.0,
                  height: 40.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: subsOn,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      subsOn = val;
                    });
                  },
                ),

                const SizedBox(
                  width: 50,
                ),

                subsOn == false ? const Text('Desactivado') : const Text('Activado'),
                
              ]
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              children: const [
                Text("DONACION", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              children: [
                FlutterSwitch(
                  width: 100.0,
                  height: 40.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  value: tipsOn,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      tipsOn = val;
                    });
                  },
                ),

                const SizedBox(
                  width: 50,
                ),
                
                tipsOn == false ? const Text('Desactivado') : const Text('Activado'),
                
              ]
            ),

            const SizedBox(
              height: 60,
            ),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { 
                  updateSubscription(globals.idProfileLogged, double.parse(amountController.text), subsOn, tipsOn);      
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),           
            
            // const SizedBox(
            //   height: 30,
            // ),

            // TextFormField(
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Cantidad mínima',
            //     labelStyle: TextStyle(
            //     color: Colors.brown,
            //   ),
            //   enabledBorder: OutlineInputBorder(
            //     borderSide: BorderSide(
            //     color: Colors.brown,
            //   )),
            //   focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(
            //     color: Colors.brown,
            //   ))),
            //   style: const TextStyle(color: Colors.black),
            // ),
 
            // const SizedBox(
            //   height: 30,
            // ),

            // SizedBox(
            //   height: 50,
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {        
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8.0),
            //       ),
            //     ),
            //     child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),
            //     ),
            //   ),           

          ],
        ),
      ),
    );
  }
}