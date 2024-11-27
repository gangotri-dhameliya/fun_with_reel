import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reels_app/UI/screens/Games/CatchTheBall/catch_the_ball.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class TicTacToeScreen extends StatefulWidget {
  TicTacToeScreen({required this.onGameWin,required this.onGameLoss,required this.winPoint});
  void Function() onGameWin;
  void Function() onGameLoss;
  int winPoint;
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));
  String _currentPlayer = 'X';
  bool _gameOver = false;
  String? _winner;

  void _playMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner();
        if (!_gameOver) {
          _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
          if (_currentPlayer == 'O') {
            _makeComputerMove();
          }
        }
        else{
          Future.delayed(Duration(seconds: 2),
          () {
            if(_winner == "X"){
              widget.onGameWin();
            }else{
              widget.onGameLoss();
            }
          },
          );
        }
      });
    }
  }

  void _makeComputerMove() {
    Timer(Duration(milliseconds: 500), () {
      List<int> emptyCells = [];
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (_board[i][j] == '') {
            emptyCells.add(i * 3 + j);
          }
        }
      }
      int randomIndex = Random().nextInt(emptyCells.length);
      int cell = emptyCells[randomIndex];
      int row = cell ~/ 3;
      int col = cell % 3;
      _playMove(row, col);
    });
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != '' &&
          _board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2]) {
        _gameOver = true;
        _winner = _board[i][0];

        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] != '' &&
          _board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i]) {
        _gameOver = true;
        _winner = _board[0][i];
        return;
      }
    }

    // Check diagonals
    if (_board[0][0] != '' &&
        _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2]) {
      _gameOver = true;
      _winner = _board[0][0];
      return;
    }

    if (_board[0][2] != '' &&
        _board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0]) {
      _gameOver = true;
      _winner = _board[0][2];
      return;
    }

    // Check for draw
    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      _gameOver = true;
    }

  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _gameOver = false;
      _winner = null;
    });
  }

  Widget _buildCell(int row, int col) {
    // dev.log("Row unit cell data ===> ${_board[row][col].runtimeType}");
    return GestureDetector(
      onTap: () {
        _playMove(row, col);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[100],
        ),
        child: Center(
          child: _board[row][col] == "" ?Text(
            _board[row][col],
            style: TextStyle(fontSize: 40, color: Colors.black),
          ) :Image.asset(
            _board[row][col] == "X" ? ImageConstant.avatarX : ImageConstant.avatar0,
            // style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < 3; j++) _buildCell(i, j),
                    ],
                  ),
                SizedBox(height: 20),
                if (_gameOver)
                  Text(
                    _winner != null ? _winner == "X" ? 'Winner: You' : 'Winner: Computer' : 'It\'s a Draw!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _resetGame,
                //   child: Text('Reset Game'),
                // ),
              ],
            ),
            if(_winner == "X")
            UserGameWiningWidget(winPoint: widget.winPoint,),
            if(_winner == "O")
              UserGameLooseWidget()

          ],
        ),
      ),
    );
  }
}
