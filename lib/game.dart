import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'package:snake101010/config.dart';
import 'package:snake101010/models/my_point.dart';
import 'package:snake101010/models/snake.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, size) {
              print('rebuild');
              return GameField(
                constraints: size.biggest,
              );
            },
          ),
        ));
  }
}

class GameField extends StatefulWidget {
  GameField({this.constraints, Key key}) : super(key: key);
  final Size constraints;
  @override
  _GameFieldState createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  Snake snake;
  MyPoint bounty;
  Size get size => widget.constraints;
  SnakePainter snakePainter;
  BgPainter bgPainter;
  double hPad, vPad, cellSize;

  Timer timer;

  @override
  void initState() {
    super.initState();
    cellSize = min(size.width * .92 / Config.fieldWidth,
        size.height * .92 / Config.fieldHeight);
    hPad = (size.width - cellSize * Config.fieldWidth) * .5;
    vPad = (size.height - cellSize * Config.fieldHeight) * .5;

    snake = Snake();
    updateBounty();

    bgPainter = BgPainter(cellSize, hPad: hPad, vPad: vPad);
    snakePainter = SnakePainter(
      snake,
      bounty,
      cellSize,
      hPad: hPad,
      vPad: vPad,
    );

    timer = new Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        nextTick();
      });
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void setState(Function func) {
    cellSize = min(size.width * .92 / Config.fieldWidth,
        size.height * .92 / Config.fieldHeight);
    hPad = (size.width - cellSize * Config.fieldWidth) * .5;
    vPad = (size.height - cellSize * Config.fieldHeight) * .5;

    super.setState(func);
  }

  nextTick() {
    if (!snake.moving) return;
    if (snake.addHead() == bounty) {
      print('ate bounty');
      updateBounty();
    } else {
      snake.dropTail();
    }
    snakePainter.tick(snake, bounty, timer.tick);
  }

  updateBounty() {
    MyPoint nextBounty;
    do {
      print(Config.size);
      print(snake.length);
      int bp = Random().nextInt(Config.size - snake.length);
      print(bp);
      nextBounty = MyPoint(bp % Config.fieldWidth, bp ~/ Config.fieldWidth);
    } while (snake.contains(nextBounty));
    bounty = nextBounty;
    print('new bounty is:');
    print(bounty);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onHorizontalSwipe: (SwipeDirection dir) {
        print('');
        print(dir);
        print(snake.direction);
        if (snake.direction == Direction.left ||
            snake.direction == Direction.right) return;
        snake.direction =
            dir == SwipeDirection.left ? Direction.left : Direction.right;
      },
      onVerticalSwipe: (SwipeDirection dir) {
        if (snake.direction == Direction.up ||
            snake.direction == Direction.down) return;
        snake.direction =
            dir == SwipeDirection.up ? Direction.up : Direction.down;
      },
      child: Stack(
        children: [
          CustomPaint(
            key: ValueKey(timer.tick),
            size: widget.constraints,
            painter: bgPainter,
            foregroundPainter: snakePainter,
          ),
          Positioned(
            top: vPad * .5 + cellSize,
            right: hPad * .5 + cellSize,
            child: IconButton(
              iconSize: cellSize * 2,
              splashColor: Colors.transparent,
              icon: Icon(
                snake.moving ? Icons.pause : Icons.play_arrow,
                color: Colors.white54,
                // size: cellSize * 2,
              ),
              onPressed: () => setState(() {
                if (!snake.dead) snake.moving ^= true;
              }),
            ),
          ),
          if (snake.dead)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You died.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
                Text(
                  'Restart?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text('Y',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                          )),
                      onPressed: () => setState(() {
                        updateBounty();
                        snake = Snake();
                      }),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                      ),
                    ),
                    FlatButton(
                      child: Text('N',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                          )),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  double hPad, vPad, cellSize;
  Snake snake;
  MyPoint bounty;
  int ticker = 0;
  SnakePainter(this.snake, this.bounty, this.cellSize,
      {this.hPad = 0, this.vPad = 0});

  void tick(Snake newSnake, MyPoint newBounty, int tick) {
    snake = newSnake;
    bounty = newBounty;
    // ticker = tick % 45;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset((bounty.x + .45) * cellSize + hPad,
            (bounty.y + .55) * cellSize + vPad),
        cellSize * .32,
        Paint()..color = Colors.blueGrey[900]);

    canvas.drawCircle(
        Offset((bounty.x + .5) * cellSize + hPad,
            (bounty.y + .5) * cellSize + vPad),
        cellSize * .3,
        Paint()..color = Colors.red[900]);

    canvas.drawCircle(
        Offset((bounty.x + .58) * cellSize + hPad,
            (bounty.y + .40) * cellSize + vPad),
        cellSize * .1,
        Paint()..color = Colors.red[200].withOpacity(.7));

    final mySnakePaint = Paint();

    // mySnakePaint.style = PaintingStyle.stroke;
    // mySnakePaint.strokeWidth = cellSize * .3;
    // mySnakePaint.strokeJoin = StrokeJoin.bevel;
    // mySnakePaint.strokeCap = StrokeCap.butt;

    mySnakePaint.color = Colors.indigo[900].withOpacity(.6);
    snake.body.forEach((e) => canvas.drawCircle(
        Offset(hPad + (e.x + .4) * cellSize, vPad + (e.y + .7) * cellSize),
        cellSize * .65,
        mySnakePaint));

    mySnakePaint.color = Colors.green[700];
    snake.body.forEach((e) => canvas.drawCircle(
        Offset(hPad + (e.x + .5) * cellSize, vPad + (e.y + .5) * cellSize),
        cellSize * .65,
        mySnakePaint));

    canvas.drawCircle(
        Offset(hPad + (snake.head.x + .5) * cellSize,
            vPad + (snake.head.y + .5) * cellSize),
        cellSize * .60,
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = cellSize * .16);

    mySnakePaint.color = Colors.green[200];
    snake.body.forEach((e) => canvas.drawCircle(
        Offset(hPad + (e.x + .7) * cellSize, vPad + (e.y + .3) * cellSize),
        cellSize * .1,
        mySnakePaint));

    mySnakePaint.color = Colors.indigo[900].withOpacity(.6);
    snake.body.forEach((e) => canvas.drawCircle(
        Offset(hPad + (e.x + .37) * cellSize, vPad + (e.y + .7) * cellSize),
        cellSize * .24,
        mySnakePaint));

    if (snake.dead)
      canvas.drawCircle(
          Offset(hPad + (snake.head.x + .5) * cellSize,
              vPad + (snake.head.y + .5) * cellSize),
          cellSize * .68,
          Paint()
            ..color = Colors.orange[900].withOpacity(.85)
            ..style = PaintingStyle.fill
            ..strokeWidth = cellSize * .6);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return snake.moving;
  }
}

class BgPainter extends CustomPainter {
  double hPad, vPad, cellSize;
  BgPainter(this.cellSize, {this.hPad = 0, this.vPad = 0});

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset(0, 0) & Size(cWidth * xRes, cHeight * yRes),
    //     Paint()..color = bgColor);
    final myBgPaint = Paint();
    myBgPaint.color = Colors.blueGrey[700];
    // myBgPaint.
    for (var i = 0; i < Config.fieldWidth; i++)
      for (var j = 0; j < Config.fieldHeight; j++) {
        canvas.drawCircle(
            Offset(hPad + (i + .5) * cellSize, vPad + (j + .5) * cellSize),
            cellSize * .15,
            myBgPaint);
      }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
