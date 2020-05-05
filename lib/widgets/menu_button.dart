import 'package:flutter/material.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget(
      {this.text, this.child, @required this.onPressed, this.flex = 1, Key key})
      : super(key: key);
  final int flex;
  final Widget child;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        onPressed: onPressed,
        child: FittedBox(
          child: text != null
              ? Text(
                  text,
                  style: Theme.of(context).textTheme.headline1,
                )
              : child,
        ),
      ),
    );
  }
}
