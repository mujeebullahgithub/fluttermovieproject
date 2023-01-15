import 'package:cowlar_project/components/scaffold.dart';
import 'package:cowlar_project/screens/booking%20screen/theatre_seats_maker.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/chair_painter.dart';
import '../../components/screen_painter.dart';
import '../../constants.dart';

class BookingScreenTwo extends StatelessWidget {
  const BookingScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List lst = ['Selected', 'Not Available', 'VIP (150\$)', 'Regular (50 \$)'];
    List colorList = [
      Color(0xffCD9D0F),
      unselectedIndexColor,
      Color(0xff564CA3),
      blueColor
    ];
    return MyScaffold(
      appBar: CustomAppBar(
        actionList: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: headingColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The King\'s Man',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: headingColor,
                          ),
                        ),
                        Text(
                          'March 5 2021 : 12:30 Hall 1',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Container(
              color: bgColor,
              height: 350,
              child: TheatreView(),
            ),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: lst.length,
                padding: const EdgeInsets.all(defaultPadding),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding / 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ChairPainter(
                              width: 12, height: 20, colour: colorList[index]),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 9,
                          child: Text(
                            lst[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: overviewTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: unselectedIndexColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Text(
                                '4/',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: headingColor,
                                ),
                              ),
                              Text(
                                '3 row',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: headingColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 16,
                            color: headingColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: unselectedIndexColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: headingColor,
                            ),
                          ),
                          Text(
                            '\$ 600',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: headingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: defaultPadding / 2),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Preceed to pay',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheatreView extends StatelessWidget {
  const TheatreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        ScreenPainter(),
        Text(
          'SCREEN',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 8,
            color: overviewTextColor,
          ),
        ),
        Container(
          width: size.width,
          margin: EdgeInsets.all(defaultPadding),
          child: Column(
            children: List.generate(
              ArmChairsModel.listChairs.length,
              (i) => TheatreSeatRows(
                numSeats: ArmChairsModel.listChairs[i].seats,
                rowNo: i,
              ),
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: defaultPadding / 2, horizontal: defaultPadding),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding / 4),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Icon(
                      Icons.add,
                      color: headingColor,
                    ),
                  ),
                ),
                SizedBox(width: defaultPadding / 3),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding / 4),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: headingColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ArmChairsModel {
  final int seats;

  ArmChairsModel({required this.seats});

  static List<ArmChairsModel> listChairs = [
    ArmChairsModel(seats: 18),
    ArmChairsModel(seats: 22),
    ArmChairsModel(seats: 22),
    ArmChairsModel(seats: 22),
    ArmChairsModel(seats: 24),
    ArmChairsModel(seats: 24),
    ArmChairsModel(seats: 24),
    ArmChairsModel(seats: 24),
    ArmChairsModel(seats: 24),
    ArmChairsModel(seats: 24),
  ];
}
