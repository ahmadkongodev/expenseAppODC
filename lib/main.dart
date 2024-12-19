import 'package:expense_app/notification.dart';
import 'package:flutter/material.dart';
 
import 'db/expenses_db_helper.dart';
import 'db/incomes_db_helper.dart';
import 'screens/home.dart'; 
import 'dart:async';

import 'screens/onBoarding.dart';

late ObjectBoxIncomes incomesObjectbox;
late ObjectBoxExpenses expensesObjectbox;

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  incomesObjectbox = await ObjectBoxIncomes.create();
  expensesObjectbox = await ObjectBoxExpenses.create(); 
   NotificationService.initNotification();
  //   const oneSec = Duration(minutes:1);
  // Timer.periodic(oneSec, (Timer t) =>  NotificationService.showLocalNotification("test", "ajouter vos depenses du jour", "rienn")
  //           );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
      title: 'Expense App',
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
          useMaterial3: true,
      ),
      
      home:  const OnboardingScreen(),
    );
  }
}
 