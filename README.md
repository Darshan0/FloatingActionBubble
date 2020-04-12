# Floating Action Bubble 
[![Pub](https://img.shields.io/pub/v/fab_circular_menu.svg)](https://pub.dev/packages/floating_action_bubble)
[![Pull Requests are welcome](https://img.shields.io/badge/license-MIT-blue)](https://github.com/marianocordoba/fab-circular-menu/blob/master/LICENSE)
[![Codemagic build status](https://api.codemagic.io/apps/5e9371f31838ac3981fd1397/5e9371f31838ac3981fd1396/status_badge.svg)](https://codemagic.io/apps/5e9371f31838ac3981fd1397/5e9371f31838ac3981fd1396/latest_build)


### A Flutter package to create a nice menu using a Floating Action Button.


![Showcase](https://imgur.com/IbinJsI.gif)

## Installation

Just add `floating_action_bubble` to your [pubspec.yml](https://flutter.io/using-packages/) file

```yml
dependencies:
  floating_action_bubble: 0.0.1
```

## Example

```dart
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    super.initState();


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      //Init Floating Action Bubble 
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[

          // Floating action menu item
          Bubble(
            title:"Settings",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.settings,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"Profile",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.people,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title:"Home",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.home,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: _animationController.isCompleted
            ? _animationController.reverse
            : _animationController.forward,
        
        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon 
        icon: AnimatedIcons.add_event,
      )
    );
  }

}
```

You can check for a more complete example in the [example](https://github.com/Darshan0/floating_action_bubble/master/example) directory.

## Customize

You can customize the widget appareance using the following properties:

| Property  | Description |
|----------|-------------|
| fabColor | Sets the FAB color |
| fabIcon | Sets the FAB icon while the menu is open |
| BubbleTitle | Sets the FAB icon while the menu is closed |
| BubbleTitleStyle | Sets the FAB icon while the menu is closed |
| BubbleIcon | Sets the FAB icon while the menu is closed |
| BubbleIconColor | Sets the FAB icon while the menu is closed |
| BubbleColor | Sets the FAB icon while the menu is closed |
| animation| Allows you to modify the animation curve |



## Contributing

I will be very happy if you contribute to this project, please submit a PR 😁
