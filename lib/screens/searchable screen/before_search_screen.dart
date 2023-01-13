import 'package:cowlar_project/components/appbar.dart';
import 'package:cowlar_project/components/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/gradient_view_popular.dart';
import '../../constants.dart';
import '../../cubit/search_cubit.dart';
import '../../cubit/search_done_cubit.dart';
import '../../cubit/total_searched_results.dart';
import 'after_search_screen.dart';

class SearchableScreen extends StatelessWidget {
  const SearchableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return MyScaffold(
      appBar: CustomAppBar(
        actionList: [
          BlocBuilder<SearchDoneCubit, bool>(
            builder: (context, state) {
              return state
                  ? Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<SearchDoneCubit>().toChange();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: headingColor,
                              ),
                            ),
                            BlocBuilder<TotalSearchedResults, int>(
                              builder: (context, num) {
                                return Text(
                                  '$num Results Found',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: headingColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20, vertical: defaultPadding / 2.5),
                        elevation: 0,
                        color: bgColor,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.search,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: TextField(
                                controller: myController,
                                onSubmitted: (text) {
                                  context.read<SearchDoneCubit>().toChange();
                                },
                                onChanged: (text) {
                                  context.read<SearchCubit>().toChange(text);
                                },
                                cursorColor: blueColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'TV shows, movies and more',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: headingColor,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: headingColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                //context.read<AppBarCubit>().toTrue(),
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchCubit, String>(
        builder: (context, state) {
          return (state.length > 0)
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<SearchDoneCubit, bool>(
                        builder: (context, checkDone) {
                          return (checkDone == false)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: defaultPadding * 1.5),
                                    Text(
                                      'Top Results',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: headingColor,
                                      ),
                                    ),
                                    Divider(
                                        color: Color.fromRGBO(0, 0, 0, 0.11),
                                        thickness: 1),
                                  ],
                                )
                              : Column();
                        },
                      ),
                      SearchablePage(searchKeyword: state),
                    ],
                  ),
                )
              : GridViewBuilderPopular(key: UniqueKey(), blockCount: 2);
        },
      ),
    );
  }
}
