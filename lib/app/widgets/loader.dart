import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loader extends StatefulWidget {
  final Indicator indicatorType;
  final List<Color> colors;
  final double strokeWidth;
  final Color? pathBackgroundColor;

  const Loader({
    super.key,
    this.indicatorType = Indicator.ballPulse,
    this.colors = const [Colors.white],
    this.strokeWidth = 2,
    this.pathBackgroundColor = Colors.black,
  });

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: 70,
        child: LoadingIndicator(
          indicatorType: widget.indicatorType,
          colors: widget.colors,
          strokeWidth: widget.strokeWidth,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: widget.pathBackgroundColor,
        ),
      ),
    );
  }
}
