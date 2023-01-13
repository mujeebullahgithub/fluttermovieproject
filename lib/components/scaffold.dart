import 'package:flutter/material.dart';
import 'appbar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key? key,
    required this.appBar,
    required this.body,
    this.extendBody = false,
  }) : super(key: key);
  final CustomAppBar appBar;
  final Widget body;
  final bool extendBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBody,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: appBar,
      ),
      body: body,
    );
  }
}
