import 'package:flutter/material.dart';

class Bubble {
  const Bubble(
      {@required this.title,
      @required this.titleStyle,
      @required this.iconColor,
      @required this.bubbleColor,
      @required this.icon,
      @required this.onPress});

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
      color: item.bubbleColor,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 2,
      highlightElevation: 2,
      disabledColor: item.bubbleColor,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            item.icon,
            color: item.iconColor,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            item.title,
            style: item.titleStyle,
          ),
        ],
      ),
    );
  }
}

class FloatingActionBubble extends AnimatedWidget {
  const FloatingActionBubble({
    @required this.items,
    @required this.onPress,
    @required this.icon,
    @required this.iconColor,
    @required Animation animation,
  }) : super(listenable: animation);

  final List<Bubble> items;
  final Function onPress;
  final AnimatedIconData icon;
  final Color iconColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final transform = Matrix4.translationValues(
      -(screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
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
            separatorBuilder: (_, __) => SizedBox(height: 12.0),
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        FloatingActionButton(
          backgroundColor: iconColor,
          child: AnimatedIcon(
            icon: icon,
            progress: _animation,
          ),
          onPressed: onPress,
        ),
      ],
    );
  }
}
