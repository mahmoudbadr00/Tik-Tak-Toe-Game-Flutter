//import 'dart:ffi';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:xogame/logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;
  final player = AudioPlayer();
  String path = 'assets/whoosh.mp3';
  Future<void> PlaySound(String Patht) async {
    //String audiopath = 'audios/audio1.mp3';
    path = Patht;
    await player.play(AssetSource(path));
    //path = audiopath;
  }

  List listOfWinner = [0, 0, 0, 0, 0, 0, 0, 0];
  bool winner = false;
  String lastPlayer = 'X';
  String result = '';
  int turn = 1;
  int sx = 0;
  int so = 0;
  Game g = Game();
  @override
  void initState() {
    g.board = Game().initList();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCEB583),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/paper.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color(0xffCEB583).withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Turn : player ( ',
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        lastPlayer,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color:
                                lastPlayer == 'X' ? Colors.blue : Colors.red),
                      ),
                      const Text(
                        ' )',
                        style: TextStyle(fontSize: 35),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'The player X : $sx',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'The player O : $so',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width + 50,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  for (int i = 0; i < 9; i++)
                    InkWell(
                      onTap: winner
                          ? null
                          : () {
                              PlaySound('whoosh.mp3');
                              //player.play(AssetSource('whoosh.mp3'));

                              if (g.board[i] == '') {
                                setState(() {
                                  g.board[i] = lastPlayer;
                                  winner = g.CheckWinner(
                                      i, lastPlayer, listOfWinner);

                                  if (winner) {
                                    result = lastPlayer;
                                    if (listOfWinner.contains(3) ||
                                        listOfWinner.contains(-3)) {
                                      if (lastPlayer == "X") {
                                        sx++;
                                      } else {
                                        so++;
                                      }
                                    } else {}

                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (_) {
                                          if (listOfWinner.contains(3) ||
                                              listOfWinner.contains(-3)) {
                                            if (winner) {
                                              _confettiController.play();
                                              PlaySound('win.mp3');
                                            }
                                          } else {
                                            PlaySound('lose.mp3');
                                          }

                                          return AlertDialog(
                                            title: Column(
                                              children: [
                                                Text(
                                                  listOfWinner.contains(3) ||
                                                          listOfWinner
                                                              .contains(-3)
                                                      ? lastPlayer == "X"
                                                          ? 'Player O wins , Congrats!🥳👏🏻'
                                                          : 'Player X wins , Congrats!🥳👏🏻'
                                                      : 'Drow',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 27),
                                                ),
                                                Text(
                                                    'Player X is $sx || Player O is $so'),
                                              ],
                                            ),
                                            actions: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    result = '';
                                                    g.board = Game().initList();
                                                    listOfWinner = [
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      0,
                                                      0
                                                    ];
                                                    if (lastPlayer == 'X') {
                                                      lastPlayer = 'X';
                                                    } else {
                                                      lastPlayer = 'O';
                                                    }

                                                    winner = false;
                                                  });
                                                },
                                                label: const Text('Restart'),
                                                icon: const Icon(
                                                  Icons.replay,
                                                ),
                                              ),
                                            ],
                                            content: ConfettiWidget(
                                              confettiController:
                                                  _confettiController,
                                              blastDirectionality:
                                                  BlastDirectionality.explosive,
                                              shouldLoop: true,
                                              colors: const [
                                                Colors.green,
                                                Colors.blue,
                                                Colors.pink,
                                                Colors.orange,
                                                Colors.purple
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                  if (lastPlayer == 'X') {
                                    lastPlayer = 'O';
                                  } else {
                                    lastPlayer = 'X';
                                  }
                                });
                              }
                            },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          '${g.board[i]}',
                          style: TextStyle(
                              fontSize: 60,
                              color:
                                  g.board[i] == 'X' ? Colors.blue : Colors.red),
                        )),
                      ),
                    )
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  sx = 0;
                  so = 0;
                  result = '';
                  g.board = Game().initList();
                  listOfWinner = [0, 0, 0, 0, 0, 0, 0, 0];
                  lastPlayer = 'X';
                  winner = false;
                });
              },
              label: const Text(
                'New Play',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              icon: const Icon(
                Icons.replay,
              ),
            )
          ],
        ),
      ),
    );
  }
}
