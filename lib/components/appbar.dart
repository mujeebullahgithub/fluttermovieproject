import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key, required this.actionList, this.colour = secondaryColor})
      : super(key: key);
  final List<Widget> actionList;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Color(0xffEFEFEF),
      elevation: 0,
      backgroundColor: colour,
      actions: actionList,
    );
  }
}
