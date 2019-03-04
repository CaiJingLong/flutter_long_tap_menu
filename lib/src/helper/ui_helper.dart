import 'dart:async';

import 'package:flutter/material.dart';

class UIHelper {
  UIHelper._();

  static Rect findGlobalRect(GlobalKey key) {
    RenderBox renderObject = key.currentContext?.findRenderObject();
    if (renderObject == null) {
      return null;
    }

    var globalOffset = renderObject?.localToGlobal(Offset.zero);

    if (globalOffset == null) {
      return null;
    }

    var bounds = renderObject.paintBounds;
    bounds = bounds.translate(globalOffset.dx, globalOffset.dy);
    return bounds;
  }

  static Future<Rect> measureWidgetRect({
    BuildContext context,
    Widget widget,
    BoxConstraints boxConstraints,
  }) {
    Completer<Rect> completer = Completer();
    OverlayEntry entry;
    entry = OverlayEntry(builder: (BuildContext ctx) {
      print(Theme.of(context).platform);
      return Material(
        child: MeasureWidget(
          child: widget,
          boxConstraints: boxConstraints,
          measureRect: (rect) {
            entry.remove();
            completer.complete(rect);
          },
        ),
      );
    });

    Overlay.of(context).insert(entry);
    return completer.future;
  }
}

class MeasureWidget extends StatefulWidget {
  final Widget child;
  final ValueSetter<Rect> measureRect;
  final BoxConstraints boxConstraints;

  const MeasureWidget({
    Key key,
    this.child,
    this.measureRect,
    this.boxConstraints,
  }) : super(key: key);

  @override
  MeasureWidgetState createState() => MeasureWidgetState();
}

class MeasureWidgetState extends State<MeasureWidget> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(afterFirstLayout);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: true,
      child: Center(
        child: Container(
          key: key,
          // constraints: widget.boxConstraints,
          child: widget.child,
        ),
      ),
    );
  }

  void afterFirstLayout(Duration context) {
    Rect rect = UIHelper.findGlobalRect(key);
    widget.measureRect?.call(rect);
  }
}
