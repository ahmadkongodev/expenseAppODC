import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;
  List<Map> expenseList = [
    {
      "amount": 500,
      "date": "Dec 1",
      "type": "repas",
    },
    {
      "amount": 2500,
      "date": "Dec 1",
      "type": "essence",
    },
    {
      "amount": 500,
      "date": "Dec 2",
      "type": "dons",
    },
    {
      "amount": 10000,
      "date": "Dec 2",
      "type": "loisir",
    },
    {
      "amount": 1000,
      "date": "Dec 1",
      "type": "loisir",
    },
    {
      "amount": 2000,
      "date": "Dec 2",
      "type": "repas",
    },
    {
      "amount": 500,
      "date": "Dec 4",
      "type": "repas",
    },
    {
      "amount": 2500,
      "date": "Dec 4",
      "type": "essence",
    },
    {
      "amount": 500,
      "date": "Dec 4",
      "type": "dons",
    },
    {
      "amount": 10000,
      "date": "Dec 3",
      "type": "loisir",
    },
    {
      "amount": 1000,
      "date": "Dec 3",
      "type": "loisir",
    },
    {
      "amount": 2000,
      "date": "Dec 3",
      "type": "repas",
    },
  ];
  List<Map> incomes = [
    {
      "amount": 5000,
      "date": "Dec 1",
      "type": "Job",
    },
    {
      "amount": 25000,
      "date": "Dec 1",
      "type": "Business",
    },
    {
      "amount": 5000,
      "date": "Dec 2",
      "type": "Presents",
    },
  ];

  Map<String, int> totalExpensesByType = {};
  Map<String, int> totalIncomesByType = {};
  int totalExpense = 0;
  int totalIncomes = 0;
  totalIncomesPerCategory() {
    for (var income in incomes) {
      String type = income['type'] ?? "unknown";
      int amount = income['amount'] ?? 0;

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
      String type = expense['type'] ?? "unknown";
      int amount = expense['amount'] ?? 0;

      // Ajouter au total existant ou initialiser
      totalExpensesByType[type] = (totalExpensesByType[type] ?? 0) + amount;
    }

    // Afficher le résultat
    totalExpensesByType = totalExpensesByType;

    totalExpense =
        totalExpensesByType.values.fold(0, (sum, value) => sum + value);
    setState(() {});
  }

  Map<String, int> totalExpensesByDate = {};
  Map<String, int> totalIncomessByDate = {};
  totalIncomesPerDay() {
    for (var income in incomes) {
      // Normaliser les dates pour éviter les doublons
      String normalizedDate = income['date'].toString().trim().toLowerCase();
      int amount = income['amount'] ?? 0;

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
      String normalizedDate = expense['date'].toString().trim().toLowerCase();
      int amount = expense['amount'] ?? 0;

      // Ajouter au total existant ou initialiser
      totalExpensesByDate[normalizedDate] =
          (totalExpensesByDate[normalizedDate] ?? 0) + amount;
      // Afficher le résultat
      totalExpensesByDate = totalExpensesByDate;
      setState(() {});
    }
  }

  @override
  void initState() {
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[100],
                ),
                child:  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator:const BoxDecoration(
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
                          const  Text("Avoirs"),
                            Text("$totalIncomes FCFA"),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          title:  Column(
            children: [
            const  Text(
                'Manager',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Solde: ${totalIncomes-totalExpense} FCFA',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
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
                                BarChartRodData(toY: entry.value.toDouble(), color: Colors.red)
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
                    final entry = totalExpensesByType.entries.elementAt(index);
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
      ),
    );
  }
}
