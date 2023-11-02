import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'background_widget.dart';

class FinalCalculationPage extends StatelessWidget {
  final double whiteMana;
  final double blueMana;
  final double redMana;
  final double greenMana;
  final double blackMana;

  const FinalCalculationPage({super.key, 
    required this.whiteMana,
    required this.blueMana,
    required this.redMana,
    required this.greenMana,
    required this.blackMana,
  });

  @override
  Widget build(BuildContext context) {
    final totalMana = whiteMana + blueMana + redMana + greenMana + blackMana;

    // Calculate the percentage of each color mana based on the user's input.
    final whitePercentage = whiteMana / totalMana;
    final bluePercentage = blueMana / totalMana;
    final redPercentage = redMana / totalMana;
    final greenPercentage = greenMana / totalMana;
    final blackPercentage = blackMana / totalMana;

    // Modify the list of PieChartSectionData to display the actual numbers
    final List<PieChartSectionData> sections = [
      PieChartSectionData(
          title:
              '${whiteMana < 1 ? 1 : whiteMana.toInt()}', // Display 1 if less than 1
          value: whitePercentage * 100,
          color: const Color.fromARGB(255, 255, 255, 255),
          radius: 160,
          titleStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      PieChartSectionData(
          title:
              '${blueMana < 1 ? 1 : blueMana.toInt()}', // Display 1 if less than 1
          value: bluePercentage * 100,
          color: const Color.fromARGB(255, 0, 4, 255),
          radius: 160,
          titleStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      PieChartSectionData(
          title:
              '${redMana < 1 ? 1 : redMana.toInt()}', // Display 1 if less than 1
          value: redPercentage * 100,
          color: const Color(0xffff0000),
          radius: 160,
          titleStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      PieChartSectionData(
          title:
              '${greenMana < 1 ? 1 : greenMana.toInt()}', // Display 1 if less than 1
          value: greenPercentage * 100,
          color: const Color.fromARGB(255, 0, 255, 4),
          radius: 160,
          titleStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      PieChartSectionData(
          title:
              '${blackMana < 1 ? 1 : blackMana.toInt()}', // Display 1 if less than 1
          value: blackPercentage * 100,
          color: const Color.fromARGB(255, 0, 0, 0),
          radius: 160,
          titleStyle: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Calculation'),
      ),
      body: Stack(
        children: [
          const RotatingBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Mana Distribution',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Wrap the PieChart with a SizedBox and provide constraints
                SizedBox(
                  width: 400, // Set a width
                  height: 400, // Set a height
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      borderData: FlBorderData(show: false),
                      centerSpaceRadius: 0,
                      sectionsSpace: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
