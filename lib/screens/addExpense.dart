import 'package:expense_app/main.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/screens/home.dart';
import 'package:flutter/material.dart';

import '../db/expenses_db_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required this.selectedCategory, required this.isDarkMode});

  final String selectedCategory;
final bool isDarkMode;
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.isDarkMode? Colors.black87 : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: widget.isDarkMode? Colors.white : Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor:widget.isDarkMode? Colors.black87 : Colors.white,
        centerTitle: true,
        title:   Text(
          "Ajouter une dépense",
          style: TextStyle(color: widget.isDarkMode? Colors.white : Colors.black,
        ),
      ),),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                _buildTextFormField(
                  controller: categoryController,
                  label: 'Catégorie',
                  readOnly: true,
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextFormField(
                  controller: nameController,
                  label: 'Nom de la dépense',
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextFormField(
                  controller: amountController,
                  label: 'Montant de la dépense',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      style:   TextStyle(color:widget.isDarkMode? Colors.white : Colors.black,), // Text color
      decoration: InputDecoration(
        labelText: label,
        labelStyle:   TextStyle(color: widget.isDarkMode? Colors.white : Colors.black,), // Label color
        filled: true,
        fillColor:widget.isDarkMode? Colors.black : Colors.white, // Input background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: widget.isDarkMode?Colors.white70 : Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: widget.isDarkMode? Colors.white54 : Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color:widget.isDarkMode?Colors.white: Colors.black),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Ce champ est requis';
        return null;
      },
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Expense expense = Expense(
            title: nameController.text,
            category: widget.selectedCategory,
            amount: double.parse(amountController.text),
            date: DateTime.now(),
          );
          ObjectBoxExpenses.saveExpense(expense);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Dépense enregistrée avec succès",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false, // Remove all previous routes
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:widget.isDarkMode? Colors.white : Colors.black,
        foregroundColor:widget.isDarkMode? Colors.black : Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      child: const Text(
        'Enregistrer',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
