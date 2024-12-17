import 'package:flutter/material.dart';
import '../models/Income.dart';
import '../db/incomes_db_helper.dart';
import '../screens/home.dart';

class UpdateIncomeScreen extends StatefulWidget {
  final Income income;

  UpdateIncomeScreen({super.key, required this.income});

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

        Navigator.pop(context, true); // Retourner à l'écran précédent
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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: const Text(
          "Modifier un revenu",
          style: TextStyle(color: Colors.white),
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
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
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
