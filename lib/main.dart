import 'package:flutter/material.dart';
import 'privacy_policy.dart';
import 'color_selection.dart';
import 'background_widget.dart'; // Import the background widget

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'ManaCalculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedOption = 'Standard';
  double customTotalCards = 60.0;
  double customTotalLands = 24.0;

  Map<String, List<double>> optionData = {
    'Standard': [60.0, 24.0],
    'Draft': [40.0, 17.0],
    'Commander': [100.0, 42.0],
    'Other': [0, 0],
  };

  Map<String, String> optionDescriptions = {
    'Standard': 'A standard 60-card deck.',
    'Draft': 'A draft deck with 40 cards.',
    'Commander': 'A Commander deck with 100 cards.',
    'Other': 'Enter the total cards in your deck.',
  };

  void showCustomInputDialog(BuildContext context) async {
    String? customTotalCardsStr = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        // Use dialogContext instead
        String inputText = '';

        return AlertDialog(
          title: const Text('Enter the total amount of cards in your deck.'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Total Cards'),
                  onChanged: (value) {
                    inputText = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(null); // Use dialogContext
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop(inputText); // Use dialogContext
              },
            ),
          ],
        );
      },
    );

    if (customTotalCardsStr != null && customTotalCardsStr.isNotEmpty) {
      double inputNumber = double.tryParse(customTotalCardsStr) ?? 0.0;
      setState(() {
        customTotalCards = inputNumber;
        customTotalLands = inputNumber / 2.5;
        _selectedOption = 'Other'; // Set the dropdown to 'Other'
      });

      // Navigate to the next page
      navigateToColorSelection();
    } else if (customTotalCardsStr == null) {
      // Handle the case where the user presses cancel
      // You can add additional logic here if needed
    } else {
      // Handle the case where the input is empty or invalid
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Input Error'),
            content: const Text('Please enter a valid number or press Cancel.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToColorSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorSelectionPage(
          totalCards: customTotalCards,
          totalLands: customTotalLands,
        ),
      ),
    );
  }

  void updateTotalValues(String newValue) {
    setState(() {
      _selectedOption = newValue;
      customTotalCards = optionData[newValue]![0];
      customTotalLands = optionData[newValue]![1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManaCalculator'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the Privacy Policy page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
            child: const Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        // Use a Stack to place the RotatingBackground behind your content
        children: [
          const RotatingBackground(), // Add the RotatingBackground widget as the background
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Select your deck style",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButton<String>(
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        if (newValue == 'Other') {
                          showCustomInputDialog(context);
                        } else {
                          updateTotalValues(newValue);
                        }
                      }
                    },
                    items: optionData.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors
                                .white, // Set the dropdown item text color to white
                          ),
                        ),
                      );
                    }).toList(),
                    // Add this dropdownStyle property to customize the dropdown's style
                    dropdownColor:
                        Colors.blue, // Set the dropdown's background color
                    style: const TextStyle(
                      color: Colors
                          .white, // Set the default dropdown text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    optionDescriptions[_selectedOption] ?? '',
                    style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedOption != 'Other') {
                      navigateToColorSelection();
                      const RotatingBackground();
                    } else {
                      showCustomInputDialog(context);
                    }
                  },
                  child: const Text('Select'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
