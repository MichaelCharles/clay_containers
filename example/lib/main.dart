import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
    double? stagger(double value, double progress, double delay) {
      var newProgress = progress - (1 - delay);
      if (newProgress < 0) newProgress = 0;
      return value * (newProgress / delay);
    }

    final calculatedFirstDepth =
        stagger(firstDepth, _animationController.value, 0.25)!;
    final calculatedSecondDepth =
        stagger(secondDepth, _animationController.value, 0.5)!;
    final calculatedThirdDepth =
        stagger(thirdDepth, _animationController.value, 0.75)!;
    final calculatedFourthDepth =
        stagger(fourthDepth, _animationController.value, 1)!;

    return ClayTheme(
      themeData: const ClayThemeData(
        height: 10,
        width: 20,
        borderRadius: 360,
        textTheme: ClayTextTheme(style: TextStyle()),
        depth: 12,
      ),
      child: ColoredBox(
        color: baseColor,
        child: Center(
          child: ClayContainer(
            color: baseColor,
            height: 240,
            width: 240,
            curveType: CurveType.concave,
            spread: 30,
            depth: calculatedFirstDepth.toInt(),
            child: Center(
              child: ClayContainer(
                height: 200,
                width: 200,
                depth: calculatedSecondDepth.toInt(),
                curveType: CurveType.convex,
                color: baseColor,
                child: Center(
                  child: ClayContainer(
                    height: 160,
                    width: 160,
                    color: baseColor,
                    depth: calculatedThirdDepth.toInt(),
                    curveType: CurveType.concave,
                    child: Center(
                      child: ClayContainer(
                        height: 120,
                        width: 120,
                        color: baseColor,
                        depth: calculatedFourthDepth.toInt(),
                        curveType: CurveType.convex,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
