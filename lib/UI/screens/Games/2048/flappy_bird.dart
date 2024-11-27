import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

void main() {
  runApp(FlappyBirdGame());
}

class FlappyBirdGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlappyBirdScreen(),
    );
  }
}

class FlappyBirdScreen extends StatefulWidget {
  @override
  _FlappyBirdScreenState createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> {
  static const double birdSize = 50.0;
  static const double gravity = 1.5;
  static const double jumpHeight = -20.0;
  static const double obstacleWidth = 80.0;
  static const double obstacleGap = 500.0;
  static const double obstacleSpeed = 3.0;

  late double birdY;
  late double birdYSpeed;
  late double obstacleX;
  late double obstacleY;
  late Timer timer;
  late bool isGameOver;

  @override
  void initState() {
    super.initState();
    resetGame();
    timer = Timer.periodic(Duration(milliseconds: 20), (Timer t) {
      updateGame();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void resetGame() {
    birdY = 0;
    birdYSpeed = 0;
    obstacleX = 300;
    obstacleY = 10;
    isGameOver = false;
  }

  void updateGame() {
    if (!isGameOver) {
      setState(() {
        birdYSpeed += gravity;
        birdY += birdYSpeed;

        if (birdY + birdSize >= MediaQuery.of(context).size.height || birdY <= 0) {
          gameOver();
        }

        obstacleX -= obstacleSpeed;

        if (obstacleX < -obstacleWidth) {
          obstacleX = MediaQuery.of(context).size.width;
          obstacleY = 100 + Random().nextDouble() * (MediaQuery.of(context).size.height - obstacleGap - 200);
        }

        if ((birdY < obstacleY || birdY > obstacleY + obstacleGap) &&
            (obstacleX < birdSize + obstacleWidth && obstacleX + obstacleWidth > 0)) {
          gameOver();
        }
      });
    }
  }

  void jump() {
    setState(() {
      birdYSpeed = jumpHeight;
    });
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isGameOver) {
          jump();
        } else {
          resetGame();
          timer = Timer.periodic(Duration(milliseconds: 20), (Timer t) {
            updateGame();
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - birdSize / 2,
              top: birdY,
              child: Container(
                width: birdSize,
                height: birdSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConstant.avatar0), // You can replace this with your bird image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              left: obstacleX,
              height: MediaQuery.of(context).size.height,
              width: obstacleWidth,
              child: Column(
                children: <Widget>[
                  Container(
                    height: obstacleY,
                    color: Colors.green,
                  ),
                  SizedBox(height: obstacleGap),
                  Container(
                    height: MediaQuery.of(context).size.height - obstacleY - obstacleGap,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            if (isGameOver)
              Center(
                child: Text(
                  'Game Over',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
