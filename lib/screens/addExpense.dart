import 'package:expense_app/main.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/screens/home.dart';
import 'package:flutter/material.dart';

import '../db/expenses_db_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({super.key, required this.selectedCategory});

  String selectedCategory;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    amountController = TextEditingController();
    categoryController = TextEditingController(text: widget.selectedCategory);
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return 
    Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leading:   IconButton( icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ), onPressed: () {
          Navigator.of(context).push( MaterialPageRoute(builder: (cpntext)=> HomeScreen()));
        },),
        
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text(
          "Ajouter une dépense",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside TextFormField
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Catégorie',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    controller: categoryController,
                    
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom de la dépense';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: 'Nom de la dépense',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le montant de la dépense';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Montant de la dépense',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
    
                        Expense expense= Expense(title: nameController.text, category: widget.selectedCategory, amount: double.parse(amountController.text), date: DateTime.now());
                        ObjectBoxExpenses.saveExpense(expense);
                        var snack = const SnackBar(
                          content: Text(
                            "Dépense enregistrée avec succès",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
    
                        // Clear input fields after successful submission
                        nameController.clear();
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
        ),
      ),
    );
  }
}
