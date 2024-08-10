import 'package:calculator_app/components/my_button.dart';
import 'package:calculator_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
                          userInput += "+/-";
                          setState(() {});
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
      if (char == '+' || char == '-' || char == 'x' || char == '/') {
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

    // Evaluate from left to right without considering precedence
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double nextNumber = double.parse(tokens[i + 1]);

      if (operator == '+') {
        result += nextNumber;
      } else if (operator == '-') {
        result -= nextNumber;
      } else if (operator == 'x') {
        result *= nextNumber;
      } else if (operator == '/') {
        result /= nextNumber;
      }
    }

    answer = result.toString();
  }
}
