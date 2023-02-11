import 'dart:math';

import 'package:flutter/material.dart';

import 'cross.dart';
import 'grid.dart';
import 'line.dart';
import 'nought.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userIsCross = false;
  int boxesFilled = 0;
  int player1 = 0, player2 = 0;
  String winner = "";
  int? winStart, winEnd;
  List<bool?> symbol = [null, null, null, null, null, null, null, null, null];
  List<List<int>> winList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  int ai = 0;
  @override
  Widget build(BuildContext context) {
    if (boxesFilled == 9 && winner == "") {
      winner = "Draw!";
      userIsCross = !userIsCross;
    }
    userIsCross = !userIsCross;
    if (ai == 1) easyAI();
    if (ai == 2) mediumAI();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 230, 133, 116), Color(0xffa6c1ee)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //TIC TAC TOE
                  width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigoAccent, width: 5),
                    boxShadow: [
                      BoxShadow(color: Colors.indigo.shade300, blurRadius: 30)
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "Tic Tac Toe",
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.withOpacity(0.7),
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.indigo.withOpacity(0.7),
                          decorationStyle: TextDecorationStyle.double,
                          decorationThickness: .6,
                        ),
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  //Points
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 100, width: 10),
                        Container(
                          //CROSS
                          decoration: userIsCross || winner == "Draw!"
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red.withOpacity(0.6),
                                      width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.shade100,
                                      blurRadius: 10,
                                    )
                                  ],
                                )
                              : const BoxDecoration(),
                          child: const Cross(),
                        ),
                        const SizedBox(height: 100, width: 30),
                        Text(
                          //CROSS Points
                          player1.toString(),
                          style: TextStyle(
                            color: Colors.red.withOpacity(0.6),
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.red.withOpacity(0.6),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 100, width: 50),
                        Text(
                          //Nought Points
                          player2.toString(),
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.6),
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.blue.withOpacity(0.6),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 100, width: 30),
                        Container(
                          //NOUGHT
                          decoration: !userIsCross || winner == "Draw!"
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue.withOpacity(0.6),
                                      width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.shade100,
                                      blurRadius: 10,
                                    )
                                  ],
                                )
                              : const BoxDecoration(),
                          child: const Nought(),
                        ),
                        const SizedBox(height: 100, width: 10),
                      ],
                    ),
                  ),
                ),
                Text(
                  //Winner Details
                  winner,
                  style: TextStyle(
                    color: winner == "Draw!"
                        ? Colors.purple.withOpacity(0.6)
                        : !userIsCross
                            ? Colors.blue.withOpacity(0.6)
                            : Colors.red.withOpacity(0.6),
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        blurRadius: 50,
                        color: winner == "Draw!"
                            ? Colors.purple
                            : !userIsCross
                                ? Colors.lightBlue
                                : Colors.red,
                      )
                    ],
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: winner == "Draw!"
                        ? Colors.purple.withOpacity(0.6)
                        : !userIsCross
                            ? Colors.blue.withOpacity(0.6)
                            : Colors.red.withOpacity(0.6),
                    decorationThickness: 2,
                  ),
                ),
                FittedBox(
                  //GRID
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Stack(
                      children: [
                        const Grid(),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: 9,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                if (symbol[index] == null && winner == "") {
                                  symbol[index] = userIsCross;
                                  setState(() {
                                    boxesFilled++;
                                    bool? gameOver = check();
                                    if (gameOver != null) {
                                      if (gameOver) {
                                        winner = "X Wins!";
                                        player1++;
                                      } else {
                                        winner = "O Wins!";
                                        player2++;
                                      }
                                      userIsCross = !userIsCross;
                                    }
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0),
                                  ),
                                ),
                                child: symbol[index] == null
                                    ? Container()
                                    : symbol[index]!
                                        ? const Cross()
                                        : const Nought(),
                              ),
                            );
                          }),
                        ),
                        winner != "" && winner != "Draw!"
                            ? Line(
                                winStart: winStart!,
                                winEnd: winEnd!,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  //Play
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            //Two Player
                            onPressed: () {
                              reset();
                              ai = 0;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.withOpacity(0.7),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(75),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  topRight: Radius.circular(75),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: 130,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      " Play with friend ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.75),
                                      ),
                                    ),
                                    Icon(
                                      Icons.replay,
                                      color: Colors.black.withOpacity(0.75),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            //Single Player Easy
                            onPressed: () {
                              reset();
                              ai = 1;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.withOpacity(0.7),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(75),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  topRight: Radius.circular(75),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: 130,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      " Play with AI (Easy) ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.75),
                                      ),
                                    ),
                                    Icon(
                                      Icons.replay,
                                      color: Colors.black.withOpacity(0.75),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        //Single Player Medium
                        onPressed: () {
                          reset();
                          ai = 2;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.withOpacity(0.7),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(75),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: 130,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  " Play with AI (Medium) ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.75),
                                  ),
                                ),
                                Icon(
                                  Icons.replay,
                                  color: Colors.black.withOpacity(0.75),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void easyAI() {
    if (!userIsCross && boxesFilled != 9) {
      int random;
      do {
        random = Random().nextInt(9);
      } while (symbol[random] != null);
      symbol[random] = userIsCross;
      setAI();
    }
  }

  void mediumAI() {
    if (!userIsCross && boxesFilled != 9) {
      for (int i = 0; i < 9; i++) {
        if (symbol[i] == null) {
          symbol[i] = userIsCross;
          if (check() == userIsCross) {
            setAI();
            return;
          }
          symbol[i] = null;
        }
      }
      for (int i = 0; i < 9; i++) {
        if (symbol[i] == null) {
          symbol[i] = !userIsCross;
          if (check() == !userIsCross) {
            symbol[i] = userIsCross;
            setAI();
            return;
          }
          symbol[i] = null;
        }
      }
      int random;
      do {
        random = Random().nextInt(9);
      } while (symbol[random] != null);
      symbol[random] = userIsCross;
      setAI();
    }
  }

  void setAI() {
    setState(() {
      boxesFilled++;
      bool? gameOver = check();
      if (gameOver != null) {
        if (gameOver) {
          winner = "X Wins!";
          player1++;
        } else {
          winner = "O Wins!";
          player2++;
        }
        userIsCross = !userIsCross;
      }
      if (boxesFilled == 9 && winner == "") {
        winner = "Draw!";
        userIsCross = !userIsCross;
      }
      userIsCross = !userIsCross;
    });
  }

  void reset() {
    setState(() {
      boxesFilled = 0;
      winner = "";
      symbol = [null, null, null, null, null, null, null, null, null];
    });
  }

  bool? check() {
    for (int i = 0; i < 8; i++) {
      if ((symbol[winList[i][0]] != null) &&
          (symbol[winList[i][0]] == symbol[winList[i][1]]) &&
          (symbol[winList[i][1]] == symbol[winList[i][2]])) {
        winStart = winList[i][0];
        winEnd = winList[i][2];
        return symbol[winList[i][0]];
      }
    }
    return null;
  }
}
