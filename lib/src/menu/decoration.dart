part of './menu.dart';

class MenuDecoration {
  final TextStyle textStyle;
  final Color color;
  final Color splashColor;
  final double radius;

  final BoxConstraints constraints;
  final EdgeInsetsGeometry padding;

  const MenuDecoration({
    this.textStyle = const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    this.color = const Color(0xFF111111),
    this.splashColor = const Color(0xFF888888),
    this.radius = 5.0,
    this.constraints,
    this.padding,
  });
}
