import 'package:expense_app/db/incomes_db_helper.dart';
import 'package:expense_app/models/Income.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/screens/home.dart';
 
import '../db/expenses_db_helper.dart';
import '../models/Income.dart';

class UpdateIncomeScreen extends StatefulWidget {
  UpdateIncomeScreen({super.key, required this.income});

  Income income;

  @override
  State<UpdateIncomeScreen> createState() => _UpdateIncomeScreenState();
}

class _UpdateIncomeScreenState extends State<UpdateIncomeScreen> {
  
    final formKey = GlobalKey<FormState>();
   late TextEditingController amountController;
  late TextEditingController categoryController;
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
     amountController = TextEditingController(text: widget.income.amount.toString());
    categoryController = TextEditingController(text: widget.income.category);
  }

  @override
  void dispose() {
     amountController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar:  AppBar(
        leading:   IconButton( icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ), onPressed: () {
          Navigator.of(context).push( MaterialPageRoute(builder: (cpntext)=> HomeScreen()));
        },),
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: const Text("Modifier",  style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Category Field
              TextFormField(
                controller: categoryController,
                readOnly: true, // Make it read-only
                decoration: InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une catégorie';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.03),
    
              // Amount Field
              TextFormField(
                controller: amountController,
                focusNode: _amountFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Montant d\'argent',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.03),
    
              // Save Button
            ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          int id= widget.income.id;
                          
                         Income income= Income(id: id , category: categoryController.text, amount: double.parse(amountController.text), date: DateTime.now());
                        ObjectBoxIncomes.updateIncome(income);
                        var snack = const SnackBar(
                          content: Text(
                            "Modifier avec succès",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
    
                        // Clear input fields after successful submission
                        categoryController.clear();
                        amountController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5, // Adds shadow for a floating effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16, // Adjust the button height
                        horizontal: 32, // Adjust the button width
                      ),
                      backgroundColor: Colors.grey[
                          100], // Background color is set to transparent for gradient
                      shadowColor:
                          Colors.black.withOpacity(0.2), // Subtle shadow
                    ),
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
   }
}
