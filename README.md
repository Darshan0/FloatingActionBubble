# Floating Action Bubble 
[![Pub](https://img.shields.io/pub/v/fab_circular_menu.svg)](https://pub.dev/packages/floating_action_bubble)
[![Pull Requests are welcome](https://img.shields.io/badge/license-MIT-blue)](https://github.com/marianocordoba/fab-circular-menu/blob/master/LICENSE)
[![Codemagic build status](https://api.codemagic.io/apps/5e9371f31838ac3981fd1397/5e9371f31838ac3981fd1396/status_badge.svg)](https://codemagic.io/apps/5e9371f31838ac3981fd1397/5e9371f31838ac3981fd1396/latest_build)


A Flutter package to create a animated menu using a Floating Action Button.


![Showcase](https://imgur.com/IbinJsI.gif)

## Installation

Just add `floating_action_bubble` to your [pubspec.yml](https://flutter.io/using-packages/) file

```yml
dependencies:
  floating_action_bubble: 1.1.2
```

## Example

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Action Bubble Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: MyHomePage(title: 'Floating Action Bubble Demo')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: 'Settings',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.settings,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
              },
            ),
            // Floating action menu item
            Bubble(
              title: 'Profile',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.people,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
              },
            ),
            //Floating action menu item
            Bubble(
              title: 'Home',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.home,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Homepage()));
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.blue,

          // Floating Action button Icon
          iconData: Icons.ac_unit,
          backGroundColor: Colors.white,
        ));
  }
}
```

You can check for a more complete example in the [example](https://github.com/Darshan0/FloatingActionBubble/tree/master/example) directory.

## Customize

You can customize the widget appareance using the following properties:

| Property  | Description |
|----------|-------------|
| fabColor | Sets the FAB color |
| fabIcon | Sets the FAB icon |
| BubbleTitle | Sets the menu item title |
| BubbleTitleStyle | Sets the menu item title style |
| BubbleIcon | Sets the menu  item icon |
| BubbleIconColor | Sets the menu item icon color |
| BubbleColor | Sets the menu item color |
| animation| Allows to animated the menu items |



## Contributing

If you want to contribute to this project, please submit a PR to the development branch Thank you 😁
