import 'package:cowlar_project/components/appbar.dart';
import 'package:cowlar_project/components/scaffold.dart';
import 'package:cowlar_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingScreenOne extends StatefulWidget {
  const BookingScreenOne({super.key});

  @override
  _BookingScreenOneState createState() => _BookingScreenOneState();
}

class _BookingScreenOneState extends State<BookingScreenOne> {
  int selectedIndex = -1;
  int selectedIndexForContainer = -1;
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
                          'In theaters december 22, 2021',
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            Container(
              padding: EdgeInsets.only(left: defaultPadding),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    end: MediaQuery.of(context).size.width * 0.85),
                child: Text(
                  "Date",
                  style: GoogleFonts.poppins(
                      color: headingColor, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 5.0, left: defaultPadding, right: defaultPadding),
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (int i = 5; i < 20; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = i;
                          });
                        },
                        child: Container(
                          width: 65,
                          height: 100,
                          decoration: BoxDecoration(
                            color: (i == selectedIndex)
                                ? blueColor
                                : unselectedIndexColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '$i Mar',
                              style: GoogleFonts.poppins(
                                  color: (i == selectedIndex)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(
                  top: 5.0, left: defaultPadding, right: defaultPadding),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (int i = 1; i < 3; i++)
                    Container(
                      padding: EdgeInsets.only(right: defaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                text: i == 1 ? '12:30' : "13:30",
                                style: GoogleFonts.poppins(color: headingColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Cinetech + Hall $i',
                                      style: GoogleFonts.poppins(
                                          color: overviewTextColor)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding / 2),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                color: boxColor,
                                border: Border.all(
                                    color: (i == selectedIndex)
                                        ? blueColor
                                        : headingColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Image.asset(
                                "assets/hallimage.png",
                                fit: BoxFit.cover,
                              )),
                            ),
                          ),
                          SizedBox(height: defaultPadding / 2),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                text: "From",
                                style: GoogleFonts.poppins(
                                    color: overviewTextColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: i == 1 ? " 50\$" : " 75\$",
                                      style: GoogleFonts.poppins(
                                          color: headingColor)),
                                  TextSpan(
                                      text: " or ",
                                      style: GoogleFonts.poppins(
                                          color: overviewTextColor)),
                                  TextSpan(
                                      text:
                                          i == 1 ? "2500 bonus" : "3000 bonus",
                                      style: GoogleFonts.poppins(
                                          color: headingColor)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/selectseats');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: defaultPadding),
                height: 60,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: blueColor),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      "Select Seats",
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
