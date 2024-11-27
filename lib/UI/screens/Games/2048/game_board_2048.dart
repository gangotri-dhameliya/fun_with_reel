import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/Games/CatchTheBall/catch_the_ball.dart';


// class My2048Screen extends StatefulWidget {
//   @override
//   _My2048ScreenState createState() => _My2048ScreenState();
// }
//
// class _My2048ScreenState extends State<My2048Screen> {
//   late List<List<int>> grid;
//   static const int gridSize = 4;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeGrid();
//     addRandomTile();
//     addRandomTile();
//   }
//
//   void initializeGrid() {
//     grid = List.generate(gridSize, (index) => List<int>.filled(gridSize, 0));
//   }
//
//   void addRandomTile() {
//     List<Point<int>> emptyCells = [];
//     for (int i = 0; i < gridSize; i++) {
//       for (int j = 0; j < gridSize; j++) {
//         if (grid[i][j] == 0) {
//           emptyCells.add(Point(i, j));
//         }
//       }
//     }
//     if (emptyCells.isNotEmpty) {
//       final randomCell = emptyCells[Random().nextInt(emptyCells.length)];
//       grid[randomCell.x][randomCell.y] = Random().nextInt(2) == 0 ? 2 : 4;
//     }
//   }
//
//   void swipeLeft() {
//     setState(() {
//       for (int i = 0; i < gridSize; i++) {
//         for (int j = 0; j < gridSize - 1; j++) {
//           for (int k = j + 1; k < gridSize; k++) {
//             if (grid[i][k] != 0) {
//               if (grid[i][j] == 0) {
//                 grid[i][j] = grid[i][k];
//                 grid[i][k] = 0;
//                 break;
//               } else if (grid[i][j] == grid[i][k]) {
//                 grid[i][j] *= 2;
//                 grid[i][k] = 0;
//                 break;
//               }
//             }
//           }
//         }
//       }
//     });
//     addRandomTile();
//   }
//
//   void swipeRight() {
//     setState(() {
//       for (int i = 0; i < gridSize; i++) {
//         for (int j = gridSize - 1; j > 0; j--) {
//           for (int k = j - 1; k >= 0; k--) {
//             if (grid[i][k] != 0) {
//               if (grid[i][j] == 0) {
//                 grid[i][j] = grid[i][k];
//                 grid[i][k] = 0;
//                 break;
//               } else if (grid[i][j] == grid[i][k]) {
//                 grid[i][j] *= 2;
//                 grid[i][k] = 0;
//                 break;
//               }
//             }
//           }
//         }
//       }
//     });
//     addRandomTile();
//   }
//
//   void swipeUp() {
//     setState(() {
//       for (int j = 0; j < gridSize; j++) {
//         for (int i = 0; i < gridSize - 1; i++) {
//           for (int k = i + 1; k < gridSize; k++) {
//             if (grid[k][j] != 0) {
//               if (grid[i][j] == 0) {
//                 grid[i][j] = grid[k][j];
//                 grid[k][j] = 0;
//                 break;
//               } else if (grid[i][j] == grid[k][j]) {
//                 grid[i][j] *= 2;
//                 grid[k][j] = 0;
//                 break;
//               }
//             }
//           }
//         }
//       }
//     });
//     addRandomTile();
//   }
//
//   void swipeDown() {
//     setState(() {
//       for (int j = 0; j < gridSize; j++) {
//         for (int i = gridSize - 1; i > 0; i--) {
//           for (int k = i - 1; k >= 0; k--) {
//             if (grid[k][j] != 0) {
//               if (grid[i][j] == 0) {
//                 grid[i][j] = grid[k][j];
//                 grid[k][j] = 0;
//                 break;
//               } else if (grid[i][j] == grid[k][j]) {
//                 grid[i][j] *= 2;
//                 grid[k][j] = 0;
//                 break;
//               }
//             }
//           }
//         }
//       }
//     });
//     addRandomTile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('2048 Game'),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onVerticalDragEnd: (details) {
//             if (details.primaryVelocity! < 0) {
//               swipeUp();
//             } else if (details.primaryVelocity! > 0) {
//               swipeDown();
//             }
//           },
//           onHorizontalDragEnd: (details) {
//             if (details.primaryVelocity! < 0) {
//               swipeLeft();
//             } else if (details.primaryVelocity! > 0) {
//               swipeRight();
//             }
//           },
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               margin: EdgeInsets.all(4),
//               padding: EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: gridSize,
//                   crossAxisSpacing: 4,
//                   mainAxisSpacing: 4,
//                 ),
//                 itemCount: gridSize * gridSize,
//                 itemBuilder: (context, index) {
//                   final row = index ~/ gridSize;
//                   final col = index % gridSize;
//                   return Container(
//                     color: Colors.blueGrey[100],
//                     child: Center(
//                       child: Text(
//                         grid[row][col] == 0 ? '' : '${grid[row][col]}',
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



class My2048Screen extends StatefulWidget {
  My2048Screen({required this.winPoint,required this.onGameWin});
  void Function() onGameWin;
  int winPoint;
  @override
  _My2048ScreenState createState() => _My2048ScreenState();
}

class _My2048ScreenState extends State<My2048Screen> with AutomaticKeepAliveClientMixin{
  late List<List<int>> grid;
  static const int gridSize = 4;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initializeGrid();
    addRandomTile();
    addRandomTile();
  }

  void initializeGrid() {
    grid = List.generate(gridSize, (index) => List<int>.filled(gridSize, 0));
  }

  void addRandomTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      final randomCell = emptyCells[Random().nextInt(emptyCells.length)];
      grid[randomCell.x][randomCell.y] = Random().nextInt(2) == 0 ? 2 : 4;
    }
  }

  bool canMove() {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) return true; // There's an empty cell
        if ((i < gridSize - 1 && grid[i][j] == grid[i + 1][j]) ||
            (j < gridSize - 1 && grid[i][j] == grid[i][j + 1])) return true; // There are adjacent cells with the same value
      }
    }
    return false;
  }

  bool isGameWon() {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 2048) return true; // Game is won if a tile with value 2048 exists
      }
    }
    return false;
  }

  bool isGameLost() {
    return !canMove();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineBodyOneBaseWidget(title: "2048 Game",titleColor: Colors.black,fontWeight: FontWeight.w600,fontSize: 24,),
                  SizedBox(height: MediaQuery.sizeOf(context).height*.1,),
                  GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        swipeUp();
                      } else if (details.primaryVelocity! > 0) {
                        swipeDown();
                      }
                    },
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        swipeLeft();
                      } else if (details.primaryVelocity! > 0) {
                        swipeRight();
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridSize,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: gridSize * gridSize,
                          itemBuilder: (context, index) {
                            final row = index ~/ gridSize;
                            final col = index % gridSize;
                            return Container(
                              color: Colors.blueGrey[100],
                              child: Center(
                                child: Text(
                                  grid[row][col] == 0 ? '' : '${grid[row][col]}',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if(checkGameResult() != null && checkGameResult()!)
          UserGameWiningWidget(winPoint: widget.winPoint),
          if(checkGameResult() != null && !checkGameResult()!)
          UserGameLooseWidget()
        ],
      ),
    );
  }

  void swipeLeft() {
    setState(() {
      for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize - 1; j++) {
          for (int k = j + 1; k < gridSize; k++) {
            if (grid[i][k] != 0) {
              if (grid[i][j] == 0) {
                grid[i][j] = grid[i][k];
                grid[i][k] = 0;
                break;
              } else if (grid[i][j] == grid[i][k]) {
                grid[i][j] *= 2;
                grid[i][k] = 0;
                break;
              }
            }
          }
        }
      }
      checkGameResult();
    });
    addRandomTile();
  }

  void swipeRight() {
    setState(() {
      for (int i = 0; i < gridSize; i++) {
        for (int j = gridSize - 1; j > 0; j--) {
          for (int k = j - 1; k >= 0; k--) {
            if (grid[i][k] != 0) {
              if (grid[i][j] == 0) {
                grid[i][j] = grid[i][k];
                grid[i][k] = 0;
                break;
              } else if (grid[i][j] == grid[i][k]) {
                grid[i][j] *= 2;
                grid[i][k] = 0;
                break;
              }
            }
          }
        }
      }
      checkGameResult();
    });
    addRandomTile();
  }

  void swipeUp() {
    setState(() {
      for (int j = 0; j < gridSize; j++) {
        for (int i = 0; i < gridSize - 1; i++) {
          for (int k = i + 1; k < gridSize; k++) {
            if (grid[k][j] != 0) {
              if (grid[i][j] == 0) {
                grid[i][j] = grid[k][j];
                grid[k][j] = 0;
                break;
              } else if (grid[i][j] == grid[k][j]) {
                grid[i][j] *= 2;
                grid[k][j] = 0;
                break;
              }
            }
          }
        }
      }
      checkGameResult();
    });
    addRandomTile();
  }

  void swipeDown() {
    setState(() {
      for (int j = 0; j < gridSize; j++) {
        for (int i = gridSize - 1; i > 0; i--) {
          for (int k = i - 1; k >= 0; k--) {
            if (grid[k][j] != 0) {
              if (grid[i][j] == 0) {
                grid[i][j] = grid[k][j];
                grid[k][j] = 0;
                break;
              } else if (grid[i][j] == grid[k][j]) {
                grid[i][j] *= 2;
                grid[k][j] = 0;
                break;
              }
            }
          }
        }
      }
      checkGameResult();
    });
    addRandomTile();
  }

  bool? checkGameResult(){
    if (isGameWon()) {
      // Handle game win
      widget.onGameWin();
      return true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You won the game!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (isGameLost()) {
      // Handle game loss
      return false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('You lost the game!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}