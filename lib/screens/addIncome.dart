import 'package:expense_app/db/incomes_db_helper.dart';
import 'package:expense_app/models/Income.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AddIncomeScreen extends StatefulWidget {
  AddIncomeScreen({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _categoryController.text = widget.selectedCategory; // Pre-fill category
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
        title: const Text("Ajouter une de l'argent",  style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Category Field
              TextFormField(
                controller: _categoryController,
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
                controller: _amountController,
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
                      if (_formKey.currentState!.validate()) {
                         Income income= Income(category: widget.selectedCategory, amount: double.parse(_amountController.text), date: DateTime.now());
                        ObjectBoxIncomes.saveIncome(income);
                        var snack = const SnackBar(
                          content: Text(
                            "Enregistrée avec succès",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
    
                        // Clear input fields after successful submission
                        _categoryController.clear();
                        _amountController.clear();
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
