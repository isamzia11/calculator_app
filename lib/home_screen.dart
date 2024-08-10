import 'package:calculator_app/components/my_button.dart';
import 'package:calculator_app/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userInput = '';
  var answer = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        userInput.toString(),
                        style: const TextStyle(fontSize: 30, color: whiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      answer.toString(),
                      style: const TextStyle(fontSize: 30, color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      MyButton(
                        title: "AC",
                        onPressed: () {
                          userInput = "";
                          answer = "";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "+/-",
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              // Find the index of the last operator in the input
                              int i = userInput.length - 1;
                              while (i >= 0 &&
                                  (userInput[i] != '+' &&
                                      userInput[i] != '-' &&
                                      userInput[i] != 'x' &&
                                      userInput[i] != '/' &&
                                      userInput[i] != '%')) {
                                i--;
                              }

                              // Extract the last number
                              String lastNumber = userInput.substring(i + 1);

                              // Toggle the sign of the last number
                              if (lastNumber.isNotEmpty) {
                                if (lastNumber.startsWith('-')) {
                                  userInput = userInput.substring(0, i + 1) +
                                      lastNumber.substring(1);
                                } else {
                                  userInput = userInput.substring(0, i + 1) +
                                      '-' +
                                      lastNumber;
                                }
                              }
                            }
                          });
                        },
                      ),
                      MyButton(
                        title: "%",
                        onPressed: () {
                          userInput += "%";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "/",
                        color: Colors.orange,
                        onPressed: () {
                          userInput += "/";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton(
                        title: "7",
                        onPressed: () {
                          userInput += "7";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "8",
                        onPressed: () {
                          userInput += "8";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "9",
                        onPressed: () {
                          userInput += "9";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "x",
                        color: Colors.orange,
                        onPressed: () {
                          userInput += "x";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton(
                        title: "4",
                        onPressed: () {
                          userInput += "4";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "5",
                        onPressed: () {
                          userInput += "5";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "6",
                        onPressed: () {
                          userInput += "6";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "-",
                        color: Colors.orange,
                        onPressed: () {
                          userInput += "-";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton(
                        title: "1",
                        onPressed: () {
                          userInput += "1";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "2",
                        onPressed: () {
                          userInput += "2";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "3",
                        onPressed: () {
                          userInput += "3";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "+",
                        color: Colors.orange,
                        onPressed: () {
                          userInput += "+";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyButton(
                        title: "0",
                        onPressed: () {
                          userInput += "0";
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: ".",
                        onPressed: () {},
                      ),
                      MyButton(
                        title: "DEL",
                        onPressed: () {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                          setState(() {});
                        },
                      ),
                      MyButton(
                        title: "=",
                        color: Colors.orange,
                        onPressed: () {
                          equalPress();
                          setState(() {});
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void equalPress() {
    // Split the input into numbers and operators
    List<String> tokens = [];
    String number = '';

    // Separate numbers and operators
    for (int i = 0; i < userInput.length; i++) {
      String char = userInput[i];
      if (char == '+' ||
          char == '-' ||
          char == 'x' ||
          char == '/' ||
          char == '%') {
        if (number.isNotEmpty) {
          tokens.add(number); // Add the current number to the list
          number = '';
        }
        tokens.add(char); // Add the operator to the list
      } else {
        number += char; // Build the current number
      }
    }
    if (number.isNotEmpty) {
      tokens.add(number); // Add the last number
    }

    // Handle percentages first
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '%') {
        double prevNumber = double.parse(tokens[i - 1]);
        tokens[i - 1] = (prevNumber / 100).toString(); // Convert to percentage
        tokens.removeAt(i); // Remove the % operator
        i--; // Adjust index after removal
      }
    }

    // Convert x to * for multiplication
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == 'x') {
        tokens[i] = '*';
      }
    }

    // Evaluate the expression
    try {
      double result = _evaluateExpression(tokens);
      answer = result.toString();
    } catch (e) {
      answer = 'Error'; // Handle any errors gracefully
    }
  }

// Helper method to evaluate the expression
  double _evaluateExpression(List<String> tokens) {
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);
      if (op == '+') {
        result += num;
      } else if (op == '-') {
        result -= num;
      } else if (op == '*') {
        result *= num;
      } else if (op == '/') {
        result /= num;
      }
    }

    return result;
  }
}
