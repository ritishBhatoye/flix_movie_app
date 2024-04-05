import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/coming_soon_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
   bool _showShimmer = true;

  ApiServices apiServices = ApiServices();

  late Future<TvSeriesModel> topRatedShows;
  late Future<MovieModel> topRatedMovies;

  @override
  void initState() {
    super.initState();
    topRatedShows = apiServices.getTopRatedSeries();
    topRatedMovies = apiServices.getUpcomingMovies();

     Timer(Duration(seconds: 3), () {
      setState(() {
        _showShimmer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showShimmer ?
    
    Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            period: Duration(milliseconds: 1500),
            child:
            DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.cast,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.blue,
                  height: 27,
                  width: 28,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: '  🍿 Coming Soon  ',
                ),
                Tab(
                  text: "  🔥 Everyone's watching  ",
                ),
                Tab(
                  text: " 🔝 Top 10 TV Show",
                ),
                Tab(
                  text: " 💯 Top 10 Movies",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovieWidget(
                      imageUrl:
                          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                      logoUrl:
                          "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                      month: "Jun",
                      day: "19",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ComingSoonMovieWidget(
                      imageUrl:
                          'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                      overview:
                          'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                      logoUrl:
                          "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                      month: "Mar",
                      day: "07",
                    ),
                  ],
                ),
              ),
              ComingSoonMovieWidget(
                imageUrl:
                    'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                overview:
                    'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                logoUrl:
                    "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
                month: "Feb",
                day: "20",
              ),
              FutureBuilder<TvSeriesModel>(
                future: topRatedShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.results;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              DateTime releaseDate = data[index].firstAirDate;
                              String monthName =
                                  DateFormat('MMMM').format(releaseDate);
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ComingSoonMovieWidget(
                                      imageUrl:
                                          '$imageUrl${data[index].posterPath}',
                                      overview: '${data[index].overview}',
                                      logoUrl:
                                          '$imageUrl${data[index].backdropPath}',
                                      month: '${monthName}',
                                      day: '${data[index].firstAirDate.day}',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder<MovieModel>(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.results;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    DateTime releaseDate =
                                        data![index].releaseDate;
                                    String monthName =
                                        DateFormat('MMMM').format(releaseDate);
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ComingSoonMovieWidget(
                                              imageUrl:
                                                  '$imageUrl${data![index].posterPath}',
                                              overview:
                                                  '${data[index].overview}',
                                              logoUrl:
                                                  '$imageUrl${data![index].backdropPath}',
                                              month: '${monthName}',
                                              day:
                                                  '${data[index].releaseDate.day}')
                                        ],
                                      ),
                                    );
                                  }))
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
              // Add Tab content for Top 10 Movies
            ],
          ),
        ),
      ),
    )
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 200.0,
            //       height: 200.0,
            //       color: Colors.white,
            //     ),
            //     SizedBox(height: 20.0),
            //     Container(
            //       width: 150.0,
            //       height: 20.0,
            //       color: Colors.white,
            //     ),
            //     SizedBox(height: 20.0),
            //     Container(
            //       width: 100.0,
            //       height: 20.0,
            //       color: Colors.white,
            //     ),
            //   ],
            // ),
          )
    : DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.cast,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.blue,
                  height: 27,
                  width: 28,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: '  🍿 Coming Soon  ',
                ),
                Tab(
                  text: "  🔥 Everyone's watching  ",
                ),
                Tab(
                  text: " 🔝 Top 10 TV Show",
                ),
                Tab(
                  text: " 💯 Top 10 Movies",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovieWidget(
                      imageUrl:
                          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                      logoUrl:
                          "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                      month: "Jun",
                      day: "19",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ComingSoonMovieWidget(
                      imageUrl:
                          'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                      overview:
                          'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                      logoUrl:
                          "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                      month: "Mar",
                      day: "07",
                    ),
                  ],
                ),
              ),
              ComingSoonMovieWidget(
                imageUrl:
                    'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                overview:
                    'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                logoUrl:
                    "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
                month: "Feb",
                day: "20",
              ),
              FutureBuilder<TvSeriesModel>(
                future: topRatedShows,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.results;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              DateTime releaseDate = data[index].firstAirDate;
                              String monthName =
                                  DateFormat('MMMM').format(releaseDate);
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ComingSoonMovieWidget(
                                      imageUrl:
                                          '$imageUrl${data[index].posterPath}',
                                      overview: '${data[index].overview}',
                                      logoUrl:
                                          '$imageUrl${data[index].backdropPath}',
                                      month: '${monthName}',
                                      day: '${data[index].firstAirDate.day}',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder<MovieModel>(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.results;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    DateTime releaseDate =
                                        data![index].releaseDate;
                                    String monthName =
                                        DateFormat('MMMM').format(releaseDate);
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ComingSoonMovieWidget(
                                              imageUrl:
                                                  '$imageUrl${data![index].posterPath}',
                                              overview:
                                                  '${data[index].overview}',
                                              logoUrl:
                                                  '$imageUrl${data![index].backdropPath}',
                                              month: '${monthName}',
                                              day:
                                                  '${data[index].releaseDate.day}')
                                        ],
                                      ),
                                    );
                                  }))
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
              // Add Tab content for Top 10 Movies
            ],
          ),
        ),
      ),
    );
  }
}
