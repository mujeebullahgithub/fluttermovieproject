import 'package:cowlar_project/components/appbar.dart';
import 'package:cowlar_project/constants.dart';
import 'package:flutter/material.dart';
import '../../components/grid_view_upcoming.dart';
import '../../components/scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: CustomAppBar(
        actionList: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: const Text(
                      'Watch',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: headingColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/searchable');
                      },
                      icon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GridViewBuilderUpcoming(key: UniqueKey(), blockCount: 1),
    );
  }
}
