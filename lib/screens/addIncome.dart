import 'package:expense_app/db/incomes_db_helper.dart';
import 'package:expense_app/models/Income.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AddIncomeScreen extends StatefulWidget {
  AddIncomeScreen({super.key, required this.selectedCategory, required this.isDarkMode});

  final String selectedCategory;
  final bool isDarkMode;


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
      backgroundColor: widget.isDarkMode?   Colors.black87 : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.isDarkMode? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        backgroundColor:  widget.isDarkMode? Colors.black45 : Colors.white,
        centerTitle: true,
        title: const Text(
          "Ajouter d'argent",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Category Field
              TextFormField(
                controller: _categoryController,
                readOnly: true, // Make it read-only
                style: TextStyle(color:  widget.isDarkMode? Colors.white : Colors.black,), // Text color
                decoration: InputDecoration(
                  labelText: 'Catégorie',
                  labelStyle: TextStyle(color: widget.isDarkMode? Colors.white : Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.isDarkMode? Colors.white : Colors.black,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
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
                style: TextStyle(color: widget.isDarkMode?  Colors.white: Colors.black), // Text color
                decoration: InputDecoration(
                  labelText: 'Montant d\'argent',
                  labelStyle: TextStyle(color:  widget.isDarkMode? Colors.white : Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  widget.isDarkMode? Colors.white : Colors.black,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
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
              SizedBox(height: screenHeight * 0.05),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Income income = Income(
                      category: widget.selectedCategory,
                      amount: double.parse(_amountController.text),
                      date: DateTime.now(),
                    );
                    ObjectBoxIncomes.saveIncome(income);
                    var snack = const SnackBar(
                      content: Text(
                        "Enregistrée avec succès",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snack);
   Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false, // Remove all previous routes
          );
                    // Clear input fields after successful submission
                    _categoryController.clear();
                    _amountController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: widget.isDarkMode?  Colors.grey[100] : Colors.black, // Background color
                ),
                child: Text(
                  'Enregistrer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode? Colors.black : Colors.white, // Text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
