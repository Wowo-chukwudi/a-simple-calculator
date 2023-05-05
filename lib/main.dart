import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorPage(),
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String eqn = '0';
  String answer = '0';
  String expression = '';

  buttonTapped(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        eqn = '0';
        answer = '0';
      } else if (buttonText == '.') {
        eqn = eqn + buttonText;
      } else if (buttonText == 'DEL') {
        eqn = eqn.substring(0, eqn.length - 1);
        answer = '0';
        if (eqn == '') {
          eqn = '0';
        }
      } else if (buttonText == '=') {
        expression = eqn;
        expression = expression.replaceAll('x', '*');
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();

        answer =
            '${(exp.evaluate(EvaluationType.REAL, cm)).toStringAsFixed(1)}';
      } else {
        if (eqn == '0') {
          eqn = buttonText;
        } else {
          eqn = eqn + buttonText;
        }
      }
    });
  }

  Widget buildButtons(String buttonText, Color color) {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: TextButton(
          onPressed: () {
            buttonTapped(buttonText);
          },
          style: TextButton.styleFrom(
              backgroundColor: color, shape: const ContinuousRectangleBorder()),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150, right: 20),
            child: Text(
              eqn,
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.black, fontSize: 70),
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 10,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButtons('C', Colors.grey.shade200),
                  buildButtons('+-', Colors.grey.shade200),
                  buildButtons('%', Colors.grey.shade200),
                  buildButtons('+', const Color.fromARGB(255, 137, 233, 238)),
                ],
              ),
              Row(
                children: [
                  buildButtons('1', Colors.grey.shade200),
                  buildButtons('2', Colors.grey.shade200),
                  buildButtons('3', Colors.grey.shade200),
                  buildButtons('-', const Color.fromARGB(255, 137, 233, 238)),
                ],
              ),
              Row(
                children: [
                  buildButtons('4', Colors.grey.shade200),
                  buildButtons('5', Colors.grey.shade200),
                  buildButtons('6', Colors.grey.shade200),
                  buildButtons('x', const Color.fromARGB(255, 137, 233, 238)),
                ],
              ),
              Row(
                children: [
                  buildButtons('7', Colors.grey.shade200),
                  buildButtons('8', Colors.grey.shade200),
                  buildButtons('9', Colors.grey.shade200),
                  buildButtons('/', const Color.fromARGB(255, 137, 233, 238)),
                ],
              ),
              Row(
                children: [
                  buildButtons('0', Colors.grey.shade200),
                  buildButtons('.', Colors.grey.shade200),
                  buildButtons('DEL', Colors.grey.shade200),
                  buildButtons('=', const Color.fromARGB(255, 137, 233, 238)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class Buttons extends StatefulWidget {
//   final String buttonText;
//   final Color color;
//   const Buttons({
//     super.key,
//     required this.buttonText,
//     required this.color,
//   });

//   @override
//   State<Buttons> createState() => _ButtonsState();
// }

// class _ButtonsState extends State<Buttons> {
//   buttonTapped(String buttonText) {
//     return buttonText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SizedBox(
//         height: 79.3,
//         child: TextButton(
//           onPressed: () {
//             buttonTapped(widget.buttonText);
//           },
//           style: TextButton.styleFrom(
//               backgroundColor: widget.color,
//               shape: const ContinuousRectangleBorder()),
//           child: Text(
//             widget.buttonText,
//             style: const TextStyle(fontSize: 20, color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
// }

