import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationSize = 38;
  double resultSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'c') {
        equation = '0';
        result = '0';
        equationSize = 38;
        resultSize = 48;
      } else if (buttonText == 'del') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
        equationSize = 38;
        resultSize = 48;
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('%', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {}
      } else {
        equation = equation + buttonText;
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      // color: buttonColor,
      child: ElevatedButton(
        child: Text(buttonText,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30)),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("del", 1, Colors.grey),
                      buildButton("÷", 1, Colors.orangeAccent)
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.brown),
                      buildButton("8", 1, Colors.brown),
                      buildButton("9", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.brown),
                      buildButton("5", 1, Colors.brown),
                      buildButton("6", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.brown),
                      buildButton("2", 1, Colors.brown),
                      buildButton("3", 1, Colors.brown)
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.brown),
                      buildButton("0", 1, Colors.brown),
                      buildButton("00", 1, Colors.brown)
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.brown),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.red),
                    ])
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
