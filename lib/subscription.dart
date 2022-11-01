import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({ Key? key }) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("SUSCRIPTORES", style: TextStyle( fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.center),

            const SizedBox(
              height: 60,
            ),

            Row(
              children: const [
                Text("SUSCRIPCIÓN", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad mínima',
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
                child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),           
            
            const SizedBox(
              height: 90,
            ),

            Row(
              children: const [
                Text("DONACIÓN", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold))
              ]
            ),

            const SizedBox(
              height: 30,
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad mínima',
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
                child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),           

          ],
        ),
      ),
    );
  }
}