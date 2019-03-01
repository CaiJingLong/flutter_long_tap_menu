import 'package:flutter/material.dart';

typedef Widget ItemBuilder(
  MenuItem item,
  MenuDecoration menuDecoration,
  VoidCallback dismiss,
);

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
    this.itemBuilder = _itemBuilder,
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
    w = Wrap(
      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent: 100.0,
      // ),
      children: items
          .map((item) => widget.itemBuilder(
                item,
                menuDecoration,
                dismissBackground,
              ))
          .toList(),
      // shrinkWrap: true,
    );

    w = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(menuDecoration.radius),
        child: Container(
          alignment: Alignment.topLeft,
          color: Colors.green,
          child: w,
        ),
      ),
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

  Widget _buildItem(MenuItem item) {
    // var index = widget.items.indexOf(item);
    // var isFirst = index == 0;
    // var isLast = index == widget.items.length - 1;
    return Material(
      child: InkWell(
        splashColor: menuDecoration.splashColor,
        // color: menuDecoration.color,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Text(
            item.text,
            style: menuDecoration.textStyle,
          ),
        ),
        onTap: () {
          item.onTap();
          dismissBackground();
        },
      ),
    );
  }

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

  const MenuDecoration({
    this.textStyle = const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    this.color = const Color(0xFF111111),
    this.splashColor = const Color(0xFF888888),
    this.radius = 5.0,
  });
}

Widget _itemBuilder(
    MenuItem item, MenuDecoration menuDecoration, VoidCallback dismiss) {
  var inkWell = InkWell(
    splashColor: menuDecoration.splashColor,
    // color: menuDecoration.color,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      constraints: const BoxConstraints(
        minWidth: 77.0,
        minHeight: 33.0,
      ),
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
  return Material(
    color: menuDecoration.color,
    child: inkWell,
  );
}
