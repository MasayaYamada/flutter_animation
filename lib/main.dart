import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: LogoApp(),
      );
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 6), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener(_onAnimationStatusChanged);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        //アニメーションが終了したら、学方向にアニメーションさせる。
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        //アニメーションが最初まで戻ったら、正方向にz
        controller.forward();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) => GrowTransition(
        animation: animation,
        child: LogoWidget(),
      );
}

class GrowTransition extends StatelessWidget {
  GrowTransition({Key key, this.child, this.animation})
      : assert(child != null),
        assert(animation != null),
        super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: animation,
            child: child,
            builder: (context, child) => Container(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          ),
        ),
      );
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}
