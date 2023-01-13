import 'package:cowlar_project/backend/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../cubit/total_searched_results.dart';
import '../../models/movies_model.dart';
import '../../responsive.dart';

class SearchablePage extends StatelessWidget {
  const SearchablePage({Key? key, required this.searchKeyword})
      : super(key: key);
  final String searchKeyword;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Responsive(
      mobile: SearchableGridView(
        key: UniqueKey(),
        searchKeyword: searchKeyword,
        crossAxisCount: _size.width < 650 ? 1 : 2,
        childAspectRatio: _size.width < 650 && _size.width > 350 ? 3 : 3,
      ),
      tablet: SearchableGridView(
        key: UniqueKey(),
        searchKeyword: searchKeyword,
        crossAxisCount: 3,
      ),
      desktop: SearchableGridView(
        key: UniqueKey(),
        searchKeyword: searchKeyword,
        crossAxisCount: _size.width < 1400 ? 4 : 4,
        childAspectRatio: _size.width < 1400 ? 3 : 3,
      ),
    );
  }
}

class SearchableGridView extends StatefulWidget {
  const SearchableGridView(
      {Key? key,
      this.childAspectRatio = 3,
      this.crossAxisCount = 3,
      required this.searchKeyword})
      : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final String searchKeyword;
  @override
  State<SearchableGridView> createState() => _SearchableGridViewState();
}

class _SearchableGridViewState extends State<SearchableGridView> {
  late Stream<MoviesModel> searchedMovies;

  @override
  void initState() {
    final searchKeyword = widget.searchKeyword;
    super.initState();
    Repository repo = Repository();
    searchedMovies = repo.loadSearchMovies(searchKeyword);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MoviesModel>(
      stream: searchedMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data!;
          context
              .read<TotalSearchedResults>()
              .toChange(results.resultsList.length);
          return (results.resultsList.length > 0)
              ? GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: results.resultsList.length,
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    childAspectRatio: widget.childAspectRatio,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/moviedetail',
                          arguments: results.resultsList[index].id,
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${results.resultsList[index].imageLink}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: defaultPadding),
                              //color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${results.resultsList[index].name}',
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: headingColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Category None',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: movieCategoryColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Icon(Icons.more_horiz, color: blueColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(child: Text('No Data Found'));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
