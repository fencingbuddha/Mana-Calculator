import 'package:flutter/material.dart';
import 'final_calculation.dart';
import 'background_widget.dart'; // Import the RotatingBackground widget here

class ColorSelectionPage extends StatefulWidget {
  final double totalCards;
  final double totalLands;

  const ColorSelectionPage({super.key, required this.totalCards, required this.totalLands});

  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
  double whitePips = 0;
  double bluePips = 0;
  double redPips = 0;
  double greenPips = 0;
  double blackPips = 0;
  double totalPips = 0;

  TextEditingController whiteController = TextEditingController();
  TextEditingController blueController = TextEditingController();
  TextEditingController redController = TextEditingController();
  TextEditingController greenController = TextEditingController();
  TextEditingController blackController = TextEditingController();

  bool isAnyTextFieldNotEmpty() {
    return whiteController.text.isNotEmpty ||
        blueController.text.isNotEmpty ||
        redController.text.isNotEmpty ||
        greenController.text.isNotEmpty ||
        blackController.text.isNotEmpty;
  }

  bool isButtonEnabled() {
    return isAnyTextFieldNotEmpty();
  }

  void showValidationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Validation Error'),
          content: const Text('Please enter at least one number.'),
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

  void calculateTotalPips() {
    double white = double.tryParse(whiteController.text) ?? 0;
    double blue = double.tryParse(blueController.text) ?? 0;
    double red = double.tryParse(redController.text) ?? 0;
    double green = double.tryParse(greenController.text) ?? 0;
    double black = double.tryParse(blackController.text) ?? 0;

    // Check if any of the values are between 0 and 1
    if (white > 0 && white < 1) {
      white = 1;
    }
    if (blue > 0 && blue < 1) {
      blue = 1;
    }
    if (red > 0 && red < 1) {
      red = 1;
    }
    if (green > 0 && green < 1) {
      green = 1;
    }
    if (black > 0 && black < 1) {
      black = 1;
    }

    double newTotalPips = white + blue + red + green + black;

    setState(() {
      whitePips = white;
      bluePips = blue;
      redPips = red;
      greenPips = green;
      blackPips = black;
      totalPips = newTotalPips;
      totalPips = totalPips.roundToDouble();
      whitePips = whitePips.roundToDouble();
      bluePips = bluePips.roundToDouble();
      redPips = redPips.roundToDouble();
      greenPips = greenPips.roundToDouble();
      blackPips = blackPips.roundToDouble();
    });
  }

  void navigateToFinalPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalCalculationPage(
          whiteMana: whitePips / totalPips * widget.totalLands,
          blueMana: bluePips / totalPips * widget.totalLands,
          redMana: redPips / totalPips * widget.totalLands,
          greenMana: greenPips / totalPips * widget.totalLands,
          blackMana: blackPips / totalPips * widget.totalLands,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Selection Page'),
      ),
      body: Stack(
        children: [
          const RotatingBackground(), // Wrap your existing Scaffold with RotatingBackground
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ToggleButtonGroup(
                    whiteController,
                    'White',
                  ),
                  ToggleButtonGroup(
                    blueController,
                    'Blue',
                  ),
                  ToggleButtonGroup(
                    redController,
                    'Red',
                  ),
                  ToggleButtonGroup(
                    greenController,
                    'Green',
                  ),
                  ToggleButtonGroup(
                    blackController,
                    'Black',
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (!isAnyTextFieldNotEmpty()) {
                        showValidationDialog(); // Show the validation dialog
                      } else {
                        calculateTotalPips(); // Calculate total pips
                        navigateToFinalPage(); // Navigate to the final page
                      }
                    },
                    child: const Text('Calculate'),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleButtonGroup extends StatefulWidget {
  final TextEditingController controller;
  final String colorName;

  const ToggleButtonGroup(this.controller, this.colorName, {super.key});

  @override
  _ToggleButtonGroupState createState() => _ToggleButtonGroupState();
}

class _ToggleButtonGroupState extends State<ToggleButtonGroup> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              widget.colorName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Switch(
              value: isToggled,
              onChanged: (value) {
                setState(() {
                  isToggled = value;
                  if (!isToggled) {
                    widget.controller.clear();
                  }
                });
              },
            ),
          ],
        ),
        if (isToggled)
          TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white, // Set the text color to white
            ),
            decoration: const InputDecoration(
              labelText: 'Enter total pips please.',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
