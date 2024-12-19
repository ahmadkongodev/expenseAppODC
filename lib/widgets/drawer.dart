import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          Container(
            height: 400,
            width: double.infinity,
            color: const Color.fromARGB(255, 71, 55, 241),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/profil.png'),
                        ),
                      ),
                    ),
                    const Text(
                      "  Vous devez vous connecté pour pouvoir sauvegarder \n et restaurer les données de l'application.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/google.png",
                              width: 24, // Augmenter la taille de l'image
                              height: 24, // Augmenter la taille de l'image
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Se connecter avec google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onPressed: () {
                          // Ajoutez votre logique ici
                        },
                      ),
                    )
                  ]),
            ),
          ),
        ]),
      )),
    );
  }
}
