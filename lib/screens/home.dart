import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black87,
                    tabs: [
                      Tab(
                        child: Column(
                          children: [
                            Text("Expenses"),
                            Text("5000 FCFA"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: [
                            Text("Incomes"),
                            Text("5000 FCFA"),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          title: const Column(
            children: [
              Text(
                'Manager',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Solde: 10.000 FCFA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: AspectRatio(
              aspectRatio: 2.0,
              child: Container(
                margin: const EdgeInsets.all(24),
                child: BarChart(
                  BarChartData(
                      titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            meta.formattedValue,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ))),
                      barGroups: [
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 7)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 2)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 2)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 1)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 8)]),
                      ]),
                ),
              ),
            ),
          ),
          Column(
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
                        getTitlesWidget: (value, meta) {
                          return Text(
                            meta.formattedValue,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ))),
                      barGroups: [
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 3)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 3)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 3)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 3)]),
                        BarChartGroupData(
                            x: 0, barRods: [BarChartRodData(toY: 3)]),
                      ]),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                child: PieChart(
                  PieChartData(
                       sections: [
                        PieChartSectionData(value: 10, color: Colors.blue, title: "OK"),
                        PieChartSectionData(value: 5, color: Colors.red, title: "TEST")
                       ]
                      ),
                  duration: Duration(milliseconds: 150), // Optional
                  curve: Curves.linear, // Optional
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
