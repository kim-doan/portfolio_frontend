import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Controller/ui_controller.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var uiController = Get.put(UIController());
    var loadingController = Get.put(LoadingController());

    return Stack(
      children: [
        Container(
          width: size.width,
          // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: <Widget>[
              // Positioned.fill(child: AnimatedBackground()),
              // Positioned.fill(child: Particles(30)),
              // // Positioned.fill(child: CenteredText()),
              Obx(() {
                if (uiController.pageIndex.value <= 1)
                  return Positioned.fill(child: AnimatedBackground());
                else
                  return Container();
              }),
              Obx(() {
                if (uiController.pageIndex.value <= 1)
                  return onBottom(AnimatedWave(
                    height: 180,
                    speed: 1.0,
                  ));
                else
                  return Container();
              }),
              Obx(() {
                if (uiController.pageIndex.value <= 1)
                  return onBottom(AnimatedWave(
                    height: 120,
                    speed: 0.9,
                    offset: pi,
                  ));
                else
                  return Container();
              }),
              Obx(() {
                if (uiController.pageIndex.value <= 1)
                  return onBottom(AnimatedWave(
                    height: 220,
                    speed: 1.2,
                    offset: pi / 2,
                  ));
                else
                  return Container();
              }),
              // Positioned.fill(child: CenteredText()),
              child,
            ],
          ),
        ),
        Obx(() {
          if (loadingController.isLoading.value)
            return Opacity(
              opacity: 0.5,
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.black,
              ),
            );
          else
            return new Container();
        }),
        Obx(() {
          if (loadingController.isLoading.value)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
                SizedBox(height: 10),
                Text(
                  loadingController.text.value,
                  style: TextStyle(color: Colors.white),
                )
              ],
            );
          else
            return new Container();
        })
      ],
    );
  }
}

Widget onBottom(Widget child) => Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ),
    );

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height = 0.0, this.speed = 0.0, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimation<double>(
            duration: (5000 / speed).round().milliseconds,
            tween: 0.0.tweenTo(2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum _BgProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_BgProps>()
      ..add(_BgProps.color1, Color(0xffD38312).withOpacity(0.4).tweenTo(Colors.lightBlue.shade900.withOpacity(0.3)))
      ..add(_BgProps.color2, Color(0xffA83279).withOpacity(0.4).tweenTo(Colors.blue.shade600.withOpacity(0.3)));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 3.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [value.get(_BgProps.color1), value.get(_BgProps.color2)])),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Hello!",
      style: TextStyle(color: Colors.white),
      textScaleFactor: 5,
    ));
  }
}
// class Particles extends StatefulWidget {
//   final int numberOfParticles;

//   Particles(this.numberOfParticles);

//   @override
//   _ParticlesState createState() => _ParticlesState();
// }

// class _ParticlesState extends State<Particles> {
//   final Random random = Random();

//   final List<ParticleModel> particles = [];

//   @override
//   void initState() {
//     widget.numberOfParticles.times(() => particles.add(ParticleModel(random)));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoopAnimation(
//       tween: ConstantTween(1),
//       builder: (context, child, _) {
//         _simulateParticles();
//         return CustomPaint(
//           painter: ParticlePainter(particles),
//         );
//       },
//     );
//   }

//   _simulateParticles() {
//     particles.forEach((particle) => particle.checkIfParticleNeedsToBeRestarted());
//   }
// }

// enum _OffsetProps { x, y }

// class ParticleModel {
//   MultiTween<_OffsetProps>? tween;
//   double size = 0.0;
//   Duration duration = new Duration(milliseconds: 1000);
//   Duration startTime = new Duration(milliseconds: 1000);
//   Random? random;

//   ParticleModel(this.random) {
//     _restart();
//     _shuffle();
//   }

//   _restart({Duration time = Duration.zero}) {
//     final startPosition = Offset(-0.2 + 1.4 * random!.nextDouble(), 1.2);
//     final endPosition = Offset(-0.2 + 1.4 * random!.nextDouble(), -0.2);

//     tween = MultiTween<_OffsetProps>()
//       ..add(_OffsetProps.x, startPosition.dx.tweenTo(endPosition.dx))
//       ..add(_OffsetProps.y, startPosition.dy.tweenTo(endPosition.dy));

//     duration = 3000.milliseconds + random!.nextInt(6000).milliseconds;
//     startTime = DateTime.now().duration();
//     size = 0.2 + random!.nextDouble() * 0.4;
//   }

//   void _shuffle() {
//     startTime -= (this.random!.nextDouble() * duration.inMilliseconds).round().milliseconds;
//   }

//   checkIfParticleNeedsToBeRestarted() {
//     if (progress() == 1.0) {
//       _restart();
//     }
//   }

//   double progress() {
//     return ((DateTime.now().duration() - startTime) / duration).clamp(0.0, 1.0).toDouble();
//   }
// }

// class ParticlePainter extends CustomPainter {
//   List<ParticleModel> particles;

//   ParticlePainter(this.particles);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.white.withAlpha(50);

//     particles.forEach((particle) {
//       final progress = particle.progress();
//       final MultiTweenValues<_OffsetProps> animation = particle.tween!.transform(progress);
//       final position = Offset(
//         animation.get<double>(_OffsetProps.x) * size.width,
//         animation.get<double>(_OffsetProps.y) * size.height,
//       );
//       canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
//     });
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

// enum _ColorTween { color1, color2 }

// class AnimatedBackground extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTween<_ColorTween>()
//       ..add(
//         _ColorTween.color1,
//         Color(0xff8a113a).tweenTo(Colors.lightBlue.shade900),
//         3.seconds,
//       )
//       ..add(
//         _ColorTween.color2,
//         Color(0xff440216).tweenTo(Colors.blue.shade600),
//         3.seconds,
//       );

//     return MirrorAnimation<MultiTweenValues<_ColorTween>>(
//       tween: tween,
//       duration: tween.duration,
//       builder: (context, child, value) {
//         return Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [value.get<Color>(_ColorTween.color1), value.get<Color>(_ColorTween.color2)])),
//         );
//       },
//     );
//   }
// }

// class CenteredText extends StatelessWidget {
//   const CenteredText({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text(
//       "Welcome",
//       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
//       textScaleFactor: 4,
//     ));
//   }
// }
