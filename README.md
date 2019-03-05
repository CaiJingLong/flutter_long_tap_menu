# menu

[![pub package](https://img.shields.io/pub/v/menu.svg)](https://pub.dartlang.org/packages/menu)
![GitHub](https://img.shields.io/github/license/caijinglong/flutter_long_tap_menu.svg)

menu with flutter

just wrap your widget ,and long tap to show menu

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
  decoration: MenuDecoration(
    itemConstraints: BoxConstraints(),
  ),
);
```

## params

### Menu

| Name        | Type           | Required | Describe                     |
| ----------- | -------------- | -------- | ---------------------------- |
| child       | Widget         | true     | widget                       |
| items       | List<MenuItem> | true     | options                      |
| decoration  | MenuDecoration | false    | decoration for menu and item |
| itemBuilder | ItemBuilder    | false    | customItem                   |
| clickType   | ClickType      | false    |                              |

### MenuItem

| Name  | Type     | Required | Describe |
| ----- | -------- | -------- | -------- |
| text  | string   | true     |          |
| onTap | Function | true     | onTap    |

### MenuDecoration

| Name        | Type           | Required | Describe                                      |
| ----------- | -------------- | -------- | --------------------------------------------- |
| textStyle   | TextStyle      | false    | style of menu item                            |
| color       | Color          | false    | color of menu item                            |
| splashColor | Color          | false    | splashColor of menu item                      |
| radius      | doule          | false    | radius of menu item, only first and last item |
| constraints | BoxConstraints | false    | constraints of menu item                      |
| padding     | TextStyle      | false    | padding of menu item'text                     |

### ClickType

| Name        | Describe                         |
| ----------- | -------------------------------- |
| click       | click to show menu               |
| longPress   | longPress widget to show menu    |
| doubleClick | double click widget to show menu |
| none        | Not responding to touch events   |
