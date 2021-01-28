import 'package:flutter/material.dart';

class Bubble {
  const Bubble({
    required this.title,
    required this.onPress,
    this.titleStyle,
    this.iconColor,
    this.bubbleColor,
    this.icon,
  });

  final IconData? icon;
  final Color? iconColor;
  final Color? bubbleColor;
  final VoidCallback onPress;
  final String title;
  final TextStyle? titleStyle;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {Key? key}) : super(key: key);

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding:
          const EdgeInsets.only(top: 11, bottom: 13, left: 32, right: 32),
          elevation: 2,
          primary: item.bubbleColor),
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          item.icon != null
              ? Icon(
            item.icon,
            color: item.iconColor,
          )
              : Container(),
          const SizedBox(
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

class _DefaultHeroTag {
  const _DefaultHeroTag();

  @override
  String toString() => '<default FloatingActionBubble tag>';
}

class FloatingActionBubble extends AnimatedWidget {
  const FloatingActionBubble({
    required this.items,
    required this.onPress,
    required Animation animation,
    this.iconColor,
    this.backGroundColor,
    this.herotag,
    this.iconData,
    this.animatedIconData,
  })  : assert((iconData == null && animatedIconData != null) ||
      (iconData != null && animatedIconData == null)),
        super(listenable: animation);

  final List<Bubble> items;
  final VoidCallback onPress;
  final AnimatedIconData? animatedIconData;
  final Object? herotag;
  final IconData? iconData;
  final Color? iconColor;
  final Color? backGroundColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final textDirection = Directionality.of(context);

    final animationDirection = textDirection == TextDirection.ltr ? -1 : 1;

    final transform = Matrix4.translationValues(
      animationDirection *
          (screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: textDirection == TextDirection.ltr
          ? Alignment.centerRight
          : Alignment.centerLeft,
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
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 12.0),
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        FloatingActionButton(
          heroTag: herotag ?? const _DefaultHeroTag(),
          backgroundColor: backGroundColor,
          // iconData is mutually exclusive with animatedIconData
          // only 1 can be null at the time
          child: iconData == null && animatedIconData != null
              ? AnimatedIcon(
            icon: animatedIconData!,
            progress: _animation,
          )
              : Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: onPress,
        ),
      ],
    );
  }
}
