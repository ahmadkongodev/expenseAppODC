import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: const Color.fromARGB(255, 71, 55, 241),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const Text(
            "  Vous devez être connecté pour pouvoir sauvegarder \n et restaurer les données de l'application.",
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            label: const Text(
              "Se connecter avec google",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            icon: Image.asset("assets/google.png"),
            onPressed: () {
              // Ajoutez votre logique ici
            },
          )
        ]),
      ),
    );
  }
}
