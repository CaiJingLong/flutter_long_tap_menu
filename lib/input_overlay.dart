import 'package:flutter/material.dart';

class InputOverlay extends StatefulWidget {
  final Widget child;
  final List<InputOverlayItem> items;

  const InputOverlay({Key key, this.items, this.child}) : super(key: key);

  @override
  _InputOverlayState createState() => _InputOverlayState();
}

class _InputOverlayState extends State<InputOverlay> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onLongPress: () {
        print("onLongPress");

        var rect = findGlobalRect(key);
        print(rect);
        showItem(rect);
      },
      onTapDown: (down) {
        var p = down.globalPosition;
        print("onTapDown ${p.dx}");
        print("onTapDown ${p.dy}");
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: widget.child,
      ),
    );
  }

  OverlayEntry itemEntry;

  void showItem(Rect rect) {
    var items = widget.items;
    Widget w;

    print("top = ${rect.top}");
    print("left = ${rect.left}");

    Padding(
      padding: EdgeInsets.only(
        left: rect.left,
        top: rect.top
      ),
      child: w = Wrap(
        children: items
            .map(
              (item) => _buildItem(item),
            )
            .toList(),
      ),
    );

    itemEntry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    Overlay.of(context).insert(itemEntry);
  }

  Widget _buildItem(InputOverlayItem item) {
    return FlatButton(
      child: Text(item.text),
      onPressed: () {
        item.onTap();
        itemEntry.remove();
      },
    );
  }
}

class InputOverlayItem {
  final String text;
  final Function onTap;

  const InputOverlayItem(this.text, this.onTap);
}

Rect findGlobalRect(GlobalKey key) {
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
