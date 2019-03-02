# menu

menu with flutter

wrap your widget ,and long tap to show menu

like this:

![img](https://raw.githubusercontent.com/CaiJingLong/asset_for_picgo/master/20190301214752.png)

## Usage

```dart
import 'package:menu/menu.dart';

Menu(
  child: Container(
    width: 200,
    color: Colors.yellow,
    height: 100,
    child: Text("long press show menu"),
  ),
  items: [
    MenuItem("copy", () {}),
    MenuItem("add", _incrementCounter),
  ],
);
```