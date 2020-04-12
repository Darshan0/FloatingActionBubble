import 'package:flutter/material.dart';

class Bubble {
  const Bubble({this.title, this.iconColor , this.bubbleColor ,this.icon, this.titleStyle , this.onPress});

  final IconData icon;
  final Color iconColor;
  final Color bubbleColor;
  final Function onPress;
  final String title;
  final TextStyle titleStyle;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {Key key}) : super(key: key);

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      shape: StadiumBorder(),
      padding: EdgeInsets.only(top: 11, bottom: 13, left: 32, right: 32),
      color: item.bubbleColor != null ? item.bubbleColor : Colors.indigo,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 0,
      highlightElevation: 2,
      disabledColor: item.bubbleColor != null ? item.bubbleColor : Colors.indigo,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            visible: item.icon != null ? true : false,
            child: Icon(
              item.icon,
              color: item.iconColor !=null ? item.iconColor : Colors.white,
            ),
          ),
          Text(item.title ,style: item.titleStyle != null ? item.titleStyle : TextStyle(color: Colors.white , fontSize: 16.0),),
        ],
      ),
    );
  }
}

class FloatingActionBubble extends AnimatedWidget {
  const FloatingActionBubble({
    @required this.items,
    this.onPress,
    this.icon,
    Animation animation,
  }) : super(listenable: animation);

  final List<Bubble> items;
  final Function onPress;
  final AnimatedIcons icon;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final transform = Matrix4.translationValues(
      -(screenWidth - _animation.value * screenWidth) * ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: BubbleMenu(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height:12.0),
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        
        FloatingActionButton(
        backgroundColor: Colors.indigo,
          child: AnimatedIcon(
            icon: icon != null ? icon : AnimatedIcons.menu_close,
            progress: _animation,
          ),
          onPressed: onPress,
        ),    
      ],
    );
  }
}