import 'package:flutter/material.dart';

typedef Widget ItemBuilder(
  MenuItem item,
  MenuDecoration menuDecoration,
  VoidCallback dismiss, {
  bool isFirst,
  bool isLast,
});

class Menu extends StatefulWidget {
  final Widget child;
  final List<MenuItem> items;
  final MenuDecoration decoration;
  final ItemBuilder itemBuilder;

  const Menu({
    Key key,
    this.items,
    this.child,
    this.decoration = const MenuDecoration(),
    this.itemBuilder = defaultItemBuilder,
  }) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onLongPress: () {
        var rect = findGlobalRect(key);
        showItem(rect);
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
    w = ListView(
      scrollDirection: Axis.horizontal,
      children: items.map((item) {
        var index = widget.items.indexOf(item);
        return widget.itemBuilder(
          item,
          menuDecoration,
          dismissBackground,
          isFirst: index == 0,
          isLast: index == widget.items.length - 1,
        );
      }).toList(),
      // shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );

    w = FittedBox(
      fit: BoxFit.none,
      alignment: Alignment.topLeft,
      child: Container(
        alignment: Alignment.topLeft,
        // color: Colors.green,
        width: MediaQuery.of(context).size.width,
        child: w,
        height: 33,
      ),
    );

    w = ClipRRect(
      borderRadius: BorderRadius.circular(
        menuDecoration.radius,
      ),
      child: w,
    );

    w = Padding(
      padding: EdgeInsets.only(left: rect.left, top: rect.top),
      child: w,
    );

    var size = MediaQuery.of(context).size;

    w = Container(
      child: w,
      width: size.width,
      height: size.height,
    );

    w = GestureDetector(
      child: w,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        dismissBackground();
      },
    );

    itemEntry = OverlayEntry(builder: (BuildContext context) => w);

    Overlay.of(context).insert(itemEntry);
  }

  MenuDecoration get menuDecoration => widget.decoration;

  void dismissBackground() {
    itemEntry.remove();
    itemEntry = null;
  }
}

class MenuItem {
  final String text;
  final Function onTap;

  const MenuItem(this.text, this.onTap);
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

class MenuDecoration {
  final TextStyle textStyle;
  final Color color;
  final Color splashColor;
  final double radius;

  final BoxConstraints itemConstraints;
  final EdgeInsetsGeometry itemPadding;

  const MenuDecoration({
    this.textStyle = const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    this.color = const Color(0xFF111111),
    this.splashColor = const Color(0xFF888888),
    this.radius = 5.0,
    this.itemConstraints,
    this.itemPadding,
  });
}

Widget defaultItemBuilder(
  MenuItem item,
  MenuDecoration menuDecoration,
  VoidCallback dismiss, {
  bool isFirst,
  bool isLast,
}) {
  final BoxConstraints constraints = menuDecoration.itemConstraints ??
      const BoxConstraints(
        minWidth: 77.0,
        minHeight: 33.0,
      );

  final EdgeInsetsGeometry itemPadding = menuDecoration.itemPadding ??
      const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      );

  Widget w = InkWell(
    splashColor: menuDecoration.splashColor,
    // color: menuDecoration.color,
    child: Container(
      padding: itemPadding,
      constraints: constraints,
      alignment: Alignment.center,
      child: Text(
        item.text,
        style: menuDecoration.textStyle,
      ),
    ),
    onTap: () {
      item.onTap();
      dismiss();
    },
  );

  var r = menuDecoration.radius;
  var radius = BorderRadius.horizontal(
    left: isFirst ? Radius.circular(r) : Radius.zero,
    right: isLast ? Radius.circular(r) : Radius.zero,
  );

  w = Material(
    color: menuDecoration.color,
    child: w,
  );

  return ClipRRect(
    child: w,
    borderRadius: radius,
  );
}
