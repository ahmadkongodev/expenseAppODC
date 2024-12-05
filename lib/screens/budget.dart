import 'package:flutter/material.dart';

void main() {
  runApp(BudgetApp());
}

class BudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Utilisation d'un thème sombre
      home: BudgetScreen(),
    );
  }
}

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: () {},
                ),
                const Text(
                  'December 2024',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Monthly Budget Card
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'F CFA 14 150 / F CFA 30 000',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'F CFA 15 850',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    LinearProgressIndicator(
                      value: 14150 / 30000, // Proportion utilisée
                      backgroundColor: Colors.grey[800],
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'budget mensuel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Categories: Entire expenses',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
