import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../screens/home.dart';
import '../db/expenses_db_helper.dart';

class UpdateExpenseScreen extends StatefulWidget {
  final Expense expense;
  final bool isDarkMode;

  UpdateExpenseScreen({super.key, required this.expense, required this.isDarkMode});

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.expense.title);
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _categoryController =
        TextEditingController(text: widget.expense.category);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _updateExpense() {
    if (_formKey.currentState!.validate()) {
      final updatedExpense = Expense(
        id: widget.expense.id,
        title: _nameController.text.trim(),
        category: _categoryController.text.trim(),
        amount: double.tryParse(_amountController.text) ?? 0,
        date: DateTime.now(),
      );

      try {
        ObjectBoxExpenses.updateExpense(updatedExpense);

        _showSnackBar("Dépense modifiée avec succès", Colors.green);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>  HomeScreen(currentIndex: 1,initalIndex: 0,)),
            (route) => false, // Remove all previous routes
          );
       } catch (e) {
        _showSnackBar("Erreur lors de la mise à jour", Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: color,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      style:   TextStyle(color: widget.isDarkMode? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:   TextStyle(color: widget.isDarkMode? Colors.white70 : Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderSide:   BorderSide(color:  widget.isDarkMode? Colors.white38 : Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:   BorderSide(color:  widget.isDarkMode? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:  widget.isDarkMode? Colors.black87 : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: widget.isDarkMode? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: widget.isDarkMode? Colors.black45 : Colors.white,
        centerTitle: true,
        title:   Text(
          "Modifier une dépense",
          style: TextStyle(color: widget.isDarkMode? Colors.white : Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                _buildTextField(
                  controller: _categoryController,
                  label: 'Catégorie',
                  readOnly: true,
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField(
                  controller: _nameController,
                  label: 'Nom de la dépense',
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer le nom de la dépense'
                      : null,
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField(
                  controller: _amountController,
                  label: 'Montant de la dépense',
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Veuillez entrer le montant de la dépense'
                      : null,
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: _updateExpense,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    backgroundColor: widget.isDarkMode? Colors.grey[100] : Colors.black,
                    shadowColor:  widget.isDarkMode? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.2) ,
                  ),
                  child:   Text(
                    'Modifier',
                    style: TextStyle(
                      color: widget.isDarkMode? Colors.black : Colors.white,
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
