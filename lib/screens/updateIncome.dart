import 'package:flutter/material.dart';
import '../models/Income.dart';
import '../db/incomes_db_helper.dart';
import '../screens/home.dart';

class UpdateIncomeScreen extends StatefulWidget {
  final Income income;
  final bool isDarkMode;
  
  UpdateIncomeScreen({super.key, required this.income, required this.isDarkMode});

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
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _updateIncome() {
    if (formKey.currentState!.validate()) {
      try {
        final updatedIncome = Income(
          id: widget.income.id,
          category: categoryController.text.trim(),
          amount: double.tryParse(amountController.text) ?? 0,
          date: DateTime.now(),
        );

        ObjectBoxIncomes.updateIncome(updatedIncome);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Modification réussie",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.green,
          ),
        );


   Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false, // Remove all previous routes
          );
                } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Erreur lors de la mise à jour",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.isDarkMode? Colors.black87 : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: widget.isDarkMode? Colors.white : Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: widget.isDarkMode? Colors.black45 : Colors.white,
        centerTitle: true,
        title:   Text(
          "Modifier un revenu",
          style: TextStyle(color: widget.isDarkMode? Colors.white : Colors.black,),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              _buildTextFormField(
                controller: categoryController,
                label: "Catégorie",
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildTextFormField(
                controller: amountController,
                label: "Montant d'argent",
                keyboardType: TextInputType.number,
                focusNode: _amountFocusNode,
              ),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: _updateIncome,
                style:  ElevatedButton.styleFrom(
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
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    FocusNode? focusNode,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      readOnly: readOnly,
      style:   TextStyle(color: widget.isDarkMode? Colors.white : Colors.black,),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:   TextStyle(color:widget.isDarkMode? Colors.white : Colors.black,),
        filled: true,
        fillColor: widget.isDarkMode? Colors.black : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: widget.isDarkMode? Colors.white70 : Colors.black,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: widget.isDarkMode? Colors.white54 : Colors.black,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: widget.isDarkMode? Colors.white : Colors.black,),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
    );
  }
}
