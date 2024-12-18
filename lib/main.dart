import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'db/expenses_db_helper.dart';
import 'db/incomes_db_helper.dart';
import 'screens/home.dart'; 

late ObjectBoxIncomes incomesObjectbox;
late ObjectBoxExpenses expensesObjectbox;

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  incomesObjectbox = await ObjectBoxIncomes.create();
  expensesObjectbox = await ObjectBoxExpenses.create(); 
    
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
      
      home:  const HomeScreen(),
    );
  }
}
 