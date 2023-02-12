import 'package:flutter/material.dart';
import 'dart:math' as math show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black54,
      ),
      home: const HomePage(),
    );
  }
}

const double widthAndHeight = 100.0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween(
      begin: 0,
      end: math.pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      //front
                      Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),

                      //left
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(math.pi / 2),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //right
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-math.pi / 2),
                        child: Container(
                          color: Colors.blue,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //left
                      // Transform(
                      //   transform: Matrix4.identity()..rotateY(math.pi / 2),
                      //   child: Container(
                      //     color: Colors.red,
                      //     width: widthAndHeight,
                      //     height: widthAndHeight,
                      //   ),
                      // ),

                      // //Right
                      // Transform(
                      //   transform: Matrix4.identity()
                      //     ..translate(Vector3(widthAndHeight, 0, 0))
                      //     ..rotateY(math.pi / 2),
                      //   child: Container(
                      //     color: Colors.blue,
                      //     width: widthAndHeight,
                      //     height: widthAndHeight,
                      //   ),
                      // ),

                      // //Top
                      // Transform(
                      //   transform: Matrix4.identity()
                      //     ..translate(
                      //       Vector3(0, 0, -widthAndHeight),
                      //     )
                      //     ..rotateX(math.pi / 2),
                      //   child: Container(
                      //     color: Colors.yellow,
                      //     width: widthAndHeight,
                      //     height: widthAndHeight,
                      //   ),
                      // ),

                      // //Bottom
                      // Transform(
                      //   transform: Matrix4.identity()
                      //     ..translate(
                      //       Vector3(0, widthAndHeight, -widthAndHeight),
                      //     )
                      //     ..rotateX(math.pi / 2),
                      //   child: Container(
                      //     color: Colors.grey,
                      //     width: widthAndHeight,
                      //     height: widthAndHeight,
                      //   ),
                      // ),

                      //back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(
                            Vector3(0, 0, -widthAndHeight),
                          ),
                        child: Container(
                          color: Colors.purple,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //Up
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-math.pi / 2),
                        child: Container(
                          color: Colors.orange,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),

                      //Bottom
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(math.pi / 2),
                        child: Container(
                          color: Colors.brown,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
