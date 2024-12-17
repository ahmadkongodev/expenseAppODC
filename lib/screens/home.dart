import 'package:expense_app/db/expenses_db_helper.dart';
import 'package:expense_app/db/incomes_db_helper.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/screens/addExpense.dart';
import 'package:expense_app/screens/addIncome.dart';
import 'package:expense_app/screens/updateIncome.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

import '../models/Income.dart';
import 'updateExpense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController expenseCategoryNameController =
      TextEditingController();
  final categoryformKey = GlobalKey<FormState>();

  int currentIndex = 0;
  double budget = 35000;
  List<String> expenseCategories = ["repas", "essence", "dons", "loisirs"];
  List<Expense> expenseList = [
    Expense(
        title: "garba", category: "repas", amount: 500, date: DateTime.now()),
    Expense(
        title: "moto",
        category: "essence",
        amount: 2500,
        date: DateTime.parse("2012-02-27")),
    Expense(
        title: "garibou",
        category: "dons",
        amount: 2500,
        date: DateTime.parse("2012-02-27")),
    Expense(
        title: "faso park",
        category: "loisirs",
        amount: 5000,
        date: DateTime.parse("2012-02-12")),
    Expense(
        title: "garba",
        category: "repas",
        amount: 500,
        date: DateTime.parse("2012-02-27")),
    Expense(
        title: "moto", category: "essence", amount: 2500, date: DateTime.now()),
    Expense(
        title: "garibou", category: "dons", amount: 2500, date: DateTime.now()),
    Expense(
        title: "faso park",
        category: "loisirs",
        amount: 5000,
        date: DateTime.parse("2012-02-12")),
  ];
  List<String> incomeCategories = ["Job", "Business", "Presents"];

  List<Income> incomes = [
    Income(category: "Job", amount: 5000, date: DateTime.now()),
    Income(
        category: "Business", amount: 5000, date: DateTime.parse("2012-02-27")),
    Income(category: "Presents", amount: 5000, date: DateTime.now()),
    Income(category: "Job", amount: 5000, date: DateTime.now()),
  ];
  void getIncomes() {
    incomes = ObjectBoxIncomes.getAllIncomes();
    setState(() {});
  }

  void getExpenses() {
    expenseList = ObjectBoxExpenses.getAllExpense();
    setState(() {});
  }

  double totalExpense = 0.0;
  double totalIncomes = 0.0;

  Map<String, double> totalExpensesByDate = {};
  Map<String, double> totalIncomessByDate = {};
  totalIncomesPerDay() {
    for (var income in incomes) {
      // Normaliser les dates pour éviter les doublons
      DateTime date = income.date; // Assuming expense.date is a DateTime object
      String normalizedDate = "${date.day}";
      double amount = income.amount;

      // Ajouter au total existant ou initialiser
      totalIncomessByDate[normalizedDate] =
          (totalIncomessByDate[normalizedDate] ?? 0) + amount;
      // Afficher le résultat
      totalIncomessByDate = totalIncomessByDate;
      setState(() {});
    }
  }

  totalExpensePerDay() {
    for (var expense in expenseList) {
      // Normaliser les dates pour éviter les doublons
      DateTime date =
          expense.date; // Assuming expense.date is a DateTime object
      String normalizedDate = "${date.day}";

      double amount = expense.amount;

      // Ajouter au total existant ou initialiser
      totalExpensesByDate[normalizedDate] =
          (totalExpensesByDate[normalizedDate] ?? 0) + amount;
      // Afficher le résultat
      totalExpensesByDate = totalExpensesByDate;
      setState(() {});
    }
  }

  Map<String, double> totalExpensesByType = {};
  Map<String, double> totalIncomesByType = {};
  totalIncomesPerCategory() {
    for (var income in incomes) {
      String type = income.category;
      double amount = income.amount;

      // Ajouter au total existant ou initialiser
      totalIncomesByType[type] = (totalIncomesByType[type] ?? 0) + amount;
    }

    // Afficher le résultat
    totalIncomesByType = totalIncomesByType;

    totalIncomes =
        totalIncomesByType.values.fold(0, (sum, value) => sum + value);
    setState(() {});
  }

  totalExpensePerCategory() {
    for (var expense in expenseList) {
      String type = expense.category;
      double amount = expense.amount;

      // Ajouter au total existant ou initialiser
      totalExpensesByType[type] = (totalExpensesByType[type] ?? 0) + amount;
    }

    // Afficher le résultat
    totalExpensesByType = totalExpensesByType;

    totalExpense =
        totalExpensesByType.values.fold(0, (sum, value) => sum + value);
    setState(() {});
  }

  @override
  void initState() {
    getIncomes();
    getExpenses();
    totalExpensePerDay();
    totalExpensePerCategory();
    totalIncomesPerDay();
    totalIncomesPerCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          actions: const [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.black45,
          centerTitle: true,
          bottom: currentIndex == 3
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[100],
                      ),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black87,
                          tabs: [
                            Tab(
                              child: Column(
                                children: [
                                  const Text("Depenses"),
                                  Text("$totalExpense FCFA"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  const Text("Revenus"),
                                  Text("$totalIncomes FCFA"),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
          title: Column(
            children: [
              const Text(
                'Manager',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Solde: ${totalIncomes - totalExpense} FCFA',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: [
          //home start here
          //home expenses
          TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount:
                    expenseCategories.length + 1, // +1 pour le bouton Ajouter
                itemBuilder: (context, index) {
                  if (index == expenseCategories.length) {
                    // Widget du bouton "Ajouter une catégorie"
                    return GestureDetector(
                      onTap: () {
                        // Action pour ajouter une catégorie
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Ajouter categorie"),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: categoryformKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer le nom de la dépense';
                                      }
                                      return null;
                                    },
                                    controller: expenseCategoryNameController,
                                    decoration: const InputDecoration(
                                      labelText: "nom de la categorie",
                                      icon: Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "annuler",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    "ajouter",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    if (categoryformKey.currentState!
                                        .validate()) {
                                      try {
                                        expenseCategories.add(
                                            expenseCategoryNameController.text);
                                        categoryNameController.clear();
                                        setState(() {});
                                        Navigator.pop(context);
                                        print("added");
                                      } catch (e) {
                                        print("erreur$e");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ajouter une catégorie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Rendu des catégories existantes
                    final categorie = expenseCategories[index];
                    final amount = totalExpensesByType[categorie] ?? 0;
                    final color = _getDynamicColor(index);

                    return GestureDetector(
                      onLongPress: () {
                        expenseCategoryNameController.text = categorie;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Modifier categorie"),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: categoryformKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer le nom de la dépense';
                                      }
                                      return null;
                                    },
                                    controller: expenseCategoryNameController,
                                    decoration: const InputDecoration(
                                      labelText: "nom de la categorie",
                                      icon: Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "annuler",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    "Modifer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    if (categoryformKey.currentState!
                                        .validate()) {
                                      try {
                                        expenseCategories[index] =
                                            expenseCategoryNameController.text;
                                        categoryNameController.clear();
                                        setState(() {});
                                        Navigator.pop(context);
                                        print("updated");
                                      } catch (e) {
                                        print("erreur$e");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddExpenseScreen(
                              selectedCategory: categorie,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              color: color,
                              size: 28,
                            ),
                            Text(
                              categorie,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "F CFA $amount",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            //home incomes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount:
                    incomeCategories.length + 1, // +1 pour le bouton Ajouter
                itemBuilder: (context, index) {
                  if (index == incomeCategories.length) {
                    // Bouton "Ajouter une catégorie"
                    return GestureDetector(
                      onTap: () {
                        // Action pour ajouter une catégorie
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Ajouter categorie"),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: categoryformKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer le nom de la dépense';
                                      }
                                      return null;
                                    },
                                    controller: categoryNameController,
                                    decoration: const InputDecoration(
                                      labelText: "nom de la categorie",
                                      icon: Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "annuler",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    "ajouter",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    if (categoryformKey.currentState!
                                        .validate()) {
                                      incomeCategories
                                          .add(categoryNameController.text);

                                      setState(() {});
                                      categoryNameController.clear();
                                      Navigator.pop(context);
                                      print("done");
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.green,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ajouter une catégorie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Rendu des catégories existantes
                    final category = incomeCategories[index];
                    final amount = totalIncomesByType[category] ?? 0;
                    final color = _getDynamicColor(index);

                    return GestureDetector(
                      onLongPress: () {
                        expenseCategoryNameController.text = category;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Modifier categorie"),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: categoryformKey,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer le nom de la dépense';
                                      }
                                      return null;
                                    },
                                    controller: expenseCategoryNameController,
                                    decoration: const InputDecoration(
                                      labelText: "nom de la categorie",
                                      icon: Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "annuler",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    "Modifer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    if (categoryformKey.currentState!
                                        .validate()) {
                                      try {
                                        incomeCategories[index] =
                                            expenseCategoryNameController.text;
                                        categoryNameController.clear();
                                        setState(() {});
                                        Navigator.pop(context);
                                        print("updated");
                                      } catch (e) {
                                        print("erreur$e");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddIncomeScreen(
                              selectedCategory: category,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              color: color,
                              size: 28,
                            ),
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "F CFA $amount",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ]),
          //  Home end here

          //operations start here
          TabBarView(children: [
            //expenses operations
            ListView.builder(
              itemCount: expenseList.length,
              itemBuilder: (context, index) {
                final expense = expenseList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateExpenseScreen(expense: expense)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatter.format(expense.date),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                expense.category,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                expense.title,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          expense.amount.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text("alerte"),
                                  content: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Voulez vous vraiment supprimer ?")),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "non",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        ObjectBoxExpenses.deleteExpense(
                                            expense.id);

                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text(
                                        "oui",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
             //incomes operations
            ListView.builder(
              itemCount: incomes.length,
              itemBuilder: (context, index) {
                final income = incomes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateIncomeScreen(income: income)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatter.format(income.date),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                income.category,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          income.amount.toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text("alerte"),
                                  content: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Voulez vous vraiment supprimer ?")),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: const Text(
                                        "non",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        ObjectBoxIncomes.deleteIcome(income.id);

                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text(
                                        "oui",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]),

//operations ends 

//statistique start here
          TabBarView(children: [
            
// expenes statistique 
            ListView(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(24),
                  child: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            reservedSize: 40,
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                meta.formattedValue,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              // Map x to the corresponding date
                              if (value.toInt() <
                                  totalExpensesByDate.keys.length) {
                                return Text(
                                  totalExpensesByDate.keys
                                      .elementAt(value.toInt()),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              return const Text("");
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: totalExpensesByDate.entries
                          .map((entry) => BarChartGroupData(
                                x: totalExpensesByDate.keys
                                    .toList()
                                    .indexOf(entry.key),
                                barRods: [
                                  BarChartRodData(
                                      toY: entry.value.toDouble(),
                                      color: Colors.red)
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      sections: totalExpensesByType.entries
                          .map((entry) => PieChartSectionData(
                                value: entry.value.toDouble(),
                                color: Colors.primaries[totalExpensesByType.keys
                                        .toList()
                                        .indexOf(entry.key) %
                                    Colors.primaries
                                        .length], // Assign colors dynamically
                                title: entry.key,

                                titleStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ))
                          .toList(),
                    ),
                    duration: Duration(milliseconds: 150), // Optional
                    curve: Curves.linear, // Optional
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount: totalExpensesByType.length,
                    itemBuilder: (context, index) {
                      final entry =
                          totalExpensesByType.entries.elementAt(index);
                      final category = entry.key;
                      final amount = entry.value;
                      final percentage =
                          totalExpense == 0 ? 0 : (amount / totalExpense) * 100;

                      final random = Random(category.hashCode);
                      final color = Color.fromARGB(
                        255,
                        random.nextInt(200) + 55,
                        random.nextInt(200) + 55,
                        random.nextInt(200) + 55,
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.circle, color: color),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: percentage / 100,
                                    color: color,
                                    backgroundColor: Colors.grey.shade800,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "F CFA $amount",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${percentage.toStringAsFixed(1)} %",
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
           // incomes statistique 
            ListView(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(24),
                  child: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                meta.formattedValue,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              // Map x to the corresponding date
                              if (value.toInt() <
                                  totalIncomessByDate.keys.length) {
                                return Text(
                                  totalIncomessByDate.keys
                                      .elementAt(value.toInt()),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              return const Text("");
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: totalIncomessByDate.entries
                          .map((entry) => BarChartGroupData(
                                x: totalIncomessByDate.keys
                                    .toList()
                                    .indexOf(entry.key),
                                barRods: [
                                  BarChartRodData(toY: entry.value.toDouble())
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: PieChart(
                    PieChartData(
                      sections: totalIncomesByType.entries
                          .map((entry) => PieChartSectionData(
                                value: entry.value.toDouble(),
                                color: Colors.primaries[totalIncomesByType.keys
                                        .toList()
                                        .indexOf(entry.key) %
                                    Colors.primaries
                                        .length], // Assign colors dynamically
                                title: entry.key,

                                titleStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ))
                          .toList(),
                    ),
                    duration: Duration(milliseconds: 150), // Optional
                    curve: Curves.linear, // Optional
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    itemCount: totalIncomesByType.length,
                    itemBuilder: (context, index) {
                      final entry = totalIncomesByType.entries.elementAt(index);
                      final category = entry.key;
                      final amount = entry.value;
                      final percentage =
                          totalIncomes == 0 ? 0 : (amount / totalIncomes) * 100;

                      final random = Random(category.hashCode);
                      final color = Color.fromARGB(
                        255,
                        random.nextInt(200) + 55,
                        random.nextInt(200) + 55,
                        random.nextInt(200) + 55,
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.circle, color: color),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: percentage / 100,
                                    color: color,
                                    backgroundColor: Colors.grey.shade800,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "F CFA $amount",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${percentage.toStringAsFixed(1)} %",
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ]),

          // statistiques end here

          //budget start here
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          'Montant',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' $totalExpense F CFA  /  $budget F CFA',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              ' ${budget - totalExpense} F CFA ',
                              style: TextStyle(
                                fontSize: 14,
                                color: totalExpense / budget > 0.6
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        LinearProgressIndicator(
                          value: totalExpense / budget, // Proportion utilisée
                          backgroundColor: Colors.grey[800],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              totalExpense / budget > 0.6
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'budget mensuel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
          //budget end here
        ][currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[100],
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Operations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_sharp),
              label: 'Statistiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp),
              label: 'Budget',
            ),
          ],
        ),
      ),
    );
  }

  // Generate dynamic colors
  Color _getDynamicColor(int index) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}
