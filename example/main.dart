import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Color baseColor = const Color(0xFFf2f2f2);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? stagger(value, progress, delay) {
      progress = progress - (1 - delay);
      if (progress < 0) progress = 0;
      return value * (progress / delay);
    }

    final calculatedFirstDepth =
        stagger(firstDepth, _animationController.value, 0.25)!;
    final calculatedSecondDepth =
        stagger(secondDepth, _animationController.value, 0.5)!;
    final calculatedThirdDepth =
        stagger(thirdDepth, _animationController.value, 0.75)!;
    final calculatedFourthDepth =
        stagger(fourthDepth, _animationController.value, 1)!;

    return Container(
      color: baseColor,
      child: Center(
        child: ClayContainer(
          color: baseColor,
          height: 240,
          width: 240,
          borderRadius: 200,
          curveType: CurveType.concave,
          spread: 30,
          depth: calculatedFirstDepth.toInt(),
          child: Center(
            child: ClayContainer(
              height: 200,
              width: 200,
              borderRadius: 200,
              depth: calculatedSecondDepth.toInt(),
              curveType: CurveType.convex,
              color: baseColor,
              child: Center(
                child: ClayContainer(
                    height: 160,
                    width: 160,
                    borderRadius: 200,
                    color: baseColor,
                    depth: calculatedThirdDepth.toInt(),
                    curveType: CurveType.concave,
                    child: Center(
                        child: ClayContainer(
                      height: 120,
                      width: 120,
                      borderRadius: 200,
                      color: baseColor,
                      depth: calculatedFourthDepth.toInt(),
                      curveType: CurveType.convex,
                    ),),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

