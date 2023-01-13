import 'package:flutter/material.dart';
import '../backend/repository.dart';
import '../constants.dart';
import '../models/movies_model.dart';
import '../responsive.dart';

class GridViewBuilderUpcoming extends StatelessWidget {
  const GridViewBuilderUpcoming({Key? key, required this.blockCount})
      : super(key: key);
  final int blockCount;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Responsive(
      mobile: MoviesGridViewContainer(
        crossAxisCount: _size.width < 650 ? blockCount : blockCount + 1,
        childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.5 : 1.5,
        fontChecker: blockCount,
      ),
      tablet: MoviesGridViewContainer(
        crossAxisCount: blockCount + 2,
        fontChecker: blockCount,
      ),
      desktop: MoviesGridViewContainer(
        crossAxisCount: _size.width < 1400 ? blockCount + 3 : blockCount + 3,
        childAspectRatio: _size.width < 1400 ? 1.2 : 1.5,
        fontChecker: blockCount,
      ),
    );
  }
}

class MoviesGridViewContainer extends StatefulWidget {
  const MoviesGridViewContainer({
    Key? key,
    this.childAspectRatio = 1.5,
    this.crossAxisCount = 3,
    required this.fontChecker,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final int fontChecker;
  @override
  State<MoviesGridViewContainer> createState() =>
      _MoviesGridViewContainerState();
}

class _MoviesGridViewContainerState extends State<MoviesGridViewContainer> {
  late Stream<MoviesModel> upcomingMovies;

  @override
  void initState() {
    super.initState();
    Repository repo = Repository();
    upcomingMovies = repo.loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = (widget.fontChecker == 1) ? 18 : 12;
    double halfPadding =
        (widget.fontChecker == 1) ? defaultPadding : defaultPadding / 2;
    return StreamBuilder<MoviesModel>(
      stream: upcomingMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data!;
          return (results.resultsList.length > 0)
              ? GridView.builder(
                  shrinkWrap: true,
                  itemCount: results.resultsList.length,
                  padding: const EdgeInsets.all(defaultPadding),
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
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(
                              bottom: defaultPadding, left: halfPadding),
                          child: Text(
                            '${results.resultsList[index].name}',
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No Data Found'),
                );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
