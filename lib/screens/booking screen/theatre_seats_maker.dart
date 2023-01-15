import 'package:flutter/material.dart';
import '../../components/chair_painter.dart';
import '../../constants.dart';

class TheatreSeatRows extends StatelessWidget {
  final int numSeats;
  final int rowNo;

  const TheatreSeatRows({Key? key, required this.numSeats, required this.rowNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          numSeats,
          (i) {
            if (rowNo == 0 && (i == 2 || i == 16)) {
              return ChairPainter(
                  colour: unselectedIndexColor.withOpacity(0.5),
                  isPadding: true);
            } else if ((rowNo == 1 || rowNo == 2 || rowNo == 3) &&
                (i == 4 || i == 18)) {
              return ChairPainter(
                  colour: unselectedIndexColor.withOpacity(0.5),
                  isPadding: true);
            } else if ((rowNo == 4 ||
                    rowNo == 5 ||
                    rowNo == 6 ||
                    rowNo == 7 ||
                    rowNo == 8 ||
                    rowNo == 9) &&
                (i == 5 || i == 19)) {
              return ChairPainter(
                  colour: unselectedIndexColor.withOpacity(0.5),
                  isPadding: true);
            }
            return ChairPainter(
                colour: unselectedIndexColor.withOpacity(0.5),
                isPadding: false);
          },
        ),
      ),
    );
  }
}
