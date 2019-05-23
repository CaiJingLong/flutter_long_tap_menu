# menu

[![pub package](https://img.shields.io/pub/v/menu.svg)](https://pub.dartlang.org/packages/menu)
![GitHub](https://img.shields.io/github/license/caijinglong/flutter_long_tap_menu.svg)

menu with flutter

just wrap your widget ,and long tap to show menu

like this:

![Screenshot_2019-05-23-10-58-43-361_com.example.ex.png](https://raw.githubusercontent.com/kikt-blog/image/master/img/Screenshot_2019-05-23-10-58-43-361_com.example.ex.png)

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

| Name           | Type                                                                | Required | Describe                     |
| -------------- | ------------------------------------------------------------------- | -------- | ---------------------------- |
| child          | Widget                                                              | true     | widget                       |
| items          | List<MenuItem>                                                      | true     | options                      |
| decoration     | MenuDecoration                                                      | false    | decoration for menu and item |
| itemBuilder    | ItemBuilder                                                         | false    | customItem                   |
| clickType      | ClickType                                                           | false    |                              |
| dividerBuilder | typedef Widget DividerBuilder(BuildContext context, int lastIndex); | false    | build divider builder        |

### MenuItem

| Name  | Type     | Required | Describe |
| ----- | -------- | -------- | -------- |
| text  | string   | true     |          |
| onTap | Function | true     | onTap    |

### MenuDecoration

| Name        | Type           | Required | Describe                                      | Default                                                  |
| ----------- | -------------- | -------- | --------------------------------------------- | -------------------------------------------------------- |
| textStyle   | TextStyle      | false    | style of menu item                            | `TextStyle(fontSize: 14.0,color: Colors.white)`          |
| color       | Color          | false    | color of menu item                            | `Color(0xFF111111)`                                      |
| splashColor | Color          | false    | splashColor of menu item                      | `Color(0xFF888888)`                                      |
| radius      | doule          | false    | radius of menu item, only first and last item | `5.0`                                                    |
| constraints | BoxConstraints | false    | constraints of menu item                      | `BoxConstraints()`                                       |
| padding     | TextStyle      | false    | padding of menu item'text                     | `EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)` |

### ClickType

| Name        | Describe                         |
| ----------- | -------------------------------- |
| click       | click to show menu               |
| longPress   | longPress widget to show menu    |
| doubleClick | double click widget to show menu |
| none        | Not responding to touch events   |
