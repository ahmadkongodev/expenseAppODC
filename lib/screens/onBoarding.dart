import 'package:expense_app/db/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Bienvenue sur Expense App",
          body: "Gérez vos finances facilement avec notre application.",
          image: Image.asset("assets/Expense app.png", width: 250, height: 250,), 
        ),
        PageViewModel(
          title: "Suivi des dépenses",
          body: "Gardez une trace de toutes vos dépenses.",
          image:  Image.asset("assets/add.png",)
        ),
        PageViewModel(
          title: "Rapports détaillés ",
          body: "Analysez vos dépenses avec des rapports détaillés.",
          image:  Image.asset("assets/report.png",)
        ),
      ],
      onDone: () {
        // Quand l'utilisateur a terminé l'onboarding
        SharedPref.setUserConnectedChecker();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) =>   HomeScreen(currentIndex: 0,initalIndex: 0,)),
        );
      },
      onSkip: () {
        // Quand l'utilisateur saute l'onboarding
         SharedPref.setUserConnectedChecker();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) =>   HomeScreen(currentIndex: 0,initalIndex: 0,)),
        );
      },
      showSkipButton: true,
      skip: const Text("Passer"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Terminé", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
