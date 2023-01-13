import 'package:cowlar_project/backend/repository.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/individual_movie_model.dart';
import 'package:intl/intl.dart';

class SearchMovieDetail extends StatefulWidget {
  const SearchMovieDetail({Key? key, required this.movieId}) : super(key: key);
  final String movieId;
  @override
  State<SearchMovieDetail> createState() => _SearchMovieDetailState();
}

class _SearchMovieDetailState extends State<SearchMovieDetail> {
  late Stream<IndividualMovieResult> searchedMovie;

  @override
  void initState() {
    super.initState();
    String movieId = widget.movieId;
    Repository repo = Repository();
    searchedMovie = repo.loadMovieDetail(movieId);
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return StreamBuilder<IndividualMovieResult>(
      stream: searchedMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data!;
          String dateString = result.date;
          DateTime date = DateTime.parse(dateString);
          String formattedDate = DateFormat.yMMMEd("en_US").format(date);
          return Container(
            child: (isPortrait)
                ? Column(
                    children: [
                      Expanded(
                        child: ImageMaker(
                          movieId: widget.movieId,
                          isPotrait: isPortrait,
                          imageUrl: result.imageLink,
                          nameOfMovie: result.name,
                          date: formattedDate,
                        ),
                      ),
                      Expanded(
                        child: InfoContainer(
                          lst: result.genresData,
                          overviewText: result.overview,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ImageMaker(
                          movieId: widget.movieId,
                          isPotrait: isPortrait,
                          imageUrl: result.imageLink,
                          nameOfMovie: result.name,
                          date: formattedDate,
                        ),
                      ),
                      Expanded(
                        child: InfoContainer(
                          lst: result.genresData,
                          overviewText: result.overview,
                        ),
                      ),
                    ],
                  ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ImageMaker extends StatelessWidget {
  const ImageMaker(
      {Key? key,
      required this.isPotrait,
      required this.imageUrl,
      required this.date,
      required this.nameOfMovie,
      required this.movieId})
      : super(key: key);
  final bool isPotrait;
  final String imageUrl;
  final String nameOfMovie;
  final String date;
  final String movieId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding * 1.5),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: secondaryColor,
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500$imageUrl',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nameOfMovie,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
          ),
          Text(
            'In Theaters ' + date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
          ),
          SizedBox(height: defaultPadding / 4),
          isPotrait
              ? Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/booking');
                      },
                      child: Container(
                        width: 243,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Get Tickets',
                          style: TextStyle(
                            fontSize: 14,
                            color: whiteColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/movietrailer",
                            arguments: movieId);
                      },
                      child: Container(
                        width: 243,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: blueColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: whiteColor,
                              size: 14,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Watch Trailer',
                              style: TextStyle(
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding * 0.75),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/booking');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Get Tickets',
                              style: TextStyle(
                                fontSize: 14,
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: defaultPadding / 2),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/movietrailer",
                                arguments: movieId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: whiteColor,
                                  size: 14,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Watch Trailer',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
    required this.lst,
    required this.overviewText,
  }) : super(key: key);
  final List<Genres> lst;
  final String overviewText;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Genres',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: headingColor,
              ),
            ),
          ),
          SizedBox(height: defaultPadding * 0.75),
          Container(
            height: 30,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 5);
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: lst.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    lst[index].genreName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: defaultPadding * 0.75),
          Divider(
            color: Colors.black.withOpacity(0.05),
            thickness: 1,
          ),
          SizedBox(height: defaultPadding * 0.75),
          Container(
            child: Text(
              'Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: headingColor,
              ),
            ),
          ),
          SizedBox(height: defaultPadding * 0.75),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Text(
                overviewText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: overviewTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
