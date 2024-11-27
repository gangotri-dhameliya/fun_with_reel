import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/Games/CatchTheBall/catch_the_ball.dart';

class SnackGame extends StatefulWidget {
  void Function(int) onGameOver;
  SnackGame({required this.onGameOver});
  @override
  _SnackGameState createState() => _SnackGameState();
}

class _SnackGameState extends State<SnackGame> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _playerScore = 0;
  bool _hasStarted = true;
  late Animation<double> _snakeAnimation;
  late AnimationController _snakeController;
  List _snake = [404, 405, 406, 407];
  final int _noOfSquares = 500;
  final Duration _duration = const Duration(milliseconds: 250);
  final int _squareSize = 20;
  late String _currentSnakeDirection;
  late int _snakeFoodPosition;
  Random _random = new Random();
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while(_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);

    _snakeController.forward();
    _hasStarted = !_hasStarted;
    _gameStart();
  }

  void _gameStart() {
    Timer.periodic(const Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();
      if(_hasStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++) if (_snake.last == _snake[i]) return true;
    return false;
  }

  void _updateSnake() {
    if(!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 4) * 1;
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares) _snake.add(_snake.last + _squareSize - (_noOfSquares + _squareSize));
            else _snake.add(_snake.last + _squareSize);
            break;
          case 'UP':
            if (_snake.last < _squareSize) _snake.add(_snake.last - _squareSize + (_noOfSquares + _squareSize));
            else _snake.add(_snake.last - _squareSize);
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0) _snake.add(_snake.last + 1 - _squareSize);
            else _snake.add(_snake.last + 1);
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0) _snake.add(_snake.last - 1 + _squareSize);
            else _snake.add(_snake.last - 1);
        }

        if (_snake.last != _snakeFoodPosition) _snake.removeAt(0);
        else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
            widget.onGameOver(_playerScore);
            gameOver = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('')
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: Colors.redAccent,
      //     elevation: 20,
      //     label: Text(
      //       _hasStarted ? 'Start' : 'Pause',
      //       style: const TextStyle(),
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         if(_hasStarted) _snakeController.forward();
      //         else _snakeController.reverse();
      //         _hasStarted = !_hasStarted;
      //         _gameStart();
      //       });
      //     },
      //     icon: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _snakeAnimation)
      // ),
      body: Center(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: HeadlineBodyOneBaseWidget(title: "Snack game",titleColor: Colors.black,fontWeight: FontWeight.w600,fontSize: 24,),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height*.06,),
                Expanded(
                  child: GestureDetector(
                    onVerticalDragUpdate: (drag) {
                      if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP') _currentSnakeDirection = 'DOWN';
                      else if (drag.delta.dy < 0 && _currentSnakeDirection != 'DOWN') _currentSnakeDirection = 'UP';
                    },
                    onHorizontalDragUpdate: (drag) {
                      if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT') _currentSnakeDirection = 'RIGHT';
                      else if (drag.delta.dx < 0 && _currentSnakeDirection != 'RIGHT')  _currentSnakeDirection = 'LEFT';
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        itemCount: _squareSize + _noOfSquares,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _squareSize),
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              color: Colors.white,
                              padding: _snake.contains(index) ? const EdgeInsets.all(1) : const EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: index == _snakeFoodPosition || index == _snake.last ? BorderRadius.circular(7) : _snake.contains(index) ? BorderRadius.circular(2.5) : BorderRadius.circular(1),
                                child: Container(
                                    color: _snake.contains(index) ? Colors.black : index == _snakeFoodPosition ? Colors.green : Colors.blue
                                ),
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

            if(gameOver && _playerScore != 0)
              UserGameWiningWidget(winPoint: _playerScore),
            if(gameOver && _playerScore == 0)
              UserGameLooseWidget(),

          ],
        ),
      ),
    );
  }
}
