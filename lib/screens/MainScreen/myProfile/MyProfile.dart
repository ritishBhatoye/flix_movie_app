import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/models/userProfiles.dart';
import 'package:netflix_clone/screens/MainScreen/myProfile/manageProfile.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/screens/search_screen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/TVseries.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/myList.dart';
import 'package:netflix_clone/widgets/upcoming_movie_card_widget.dart';
import 'package:netflix_clone/widgets/voice_Assistant.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ApiServices apiServices = ApiServices();

  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowPlaying;
  late Future<TvSeriesModel> topRatedShows;

  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlaying = apiServices.getNowPlayingMovies();
    topRatedShows = apiServices.getTopRatedSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProf users = UserProf.users[0];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "My Netflix",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 30,
                    child: Image.asset(
                      "assets/New&Hot/screencast.png",
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 30,
                    child: Image.asset(
                      "assets/New&Hot/search.png",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset("assets/BottomIcons/userProfile.png"),
                    ),
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ritish",
                        style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      SizedBox(
                        width: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(right: 2),
                            backgroundColor: Colors.black,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Color(0xff323232),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.26,

                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 25),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 0, vertical: 100),
                                  child: Wrap(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Switched Profiles",
                                              style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23)),
                                          Container(
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 70, 70, 70),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.asset(
                                                    "assets/cancel.png",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      userProfRow(users: UserProf.users),
                                      SizedBox(
                                        height: 145,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          margin: EdgeInsets.only(
                                            left: 100,
                                            right: 100,
                                            top: 15,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MangageProfile()),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .mode_edit_outline_outlined,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  "Manage Profiles",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            width: 52,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 17, 0),
                                borderRadius: BorderRadius.circular(30)),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/profile/notification.png",
                                color: Colors.white,
                              ),
                            )

                            //
                            ),
                        title: Text(
                          "Notifications",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "RobotoMono",
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            width: 52,
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/profile/download.png",
                                color: Colors.white,
                              ),
                            )

                            //
                            ),
                        title: Text(
                          "Downloads",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "RobotoMono",
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 220,
                  child: MyList(
                    future: upcomingFuture,
                    headlineText: 'My List',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 220,
                  child: TvSeries(
                    future: topRatedShows,
                    headlineText: 'Continue Watching',
                  ),
                ),
              ),
               SizedBox(
                height: 20,
              ),
                     SingleChildScrollView(
                child: SizedBox(
                  height: 220,
                  child: MyList(
                    future: upcomingFuture,
                    headlineText: 'My List',
                  ),
                ),
              ),
               SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 220,
                  child: MyList(
                    future: nowPlaying,
                    headlineText: 'Continue Watching',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class userProfRow extends StatelessWidget {
  const userProfRow({
    super.key,
    required this.users,
  });
  final List<UserProf> users;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
      child: Row(
        children: users.map((user) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.5),
                width: 73, // Adjust the width as needed
                height: 72, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: user.userName == "Ritish"
                        ? Colors.white
                        : const Color.fromARGB(
                            0, 0, 0, 0), // Specify the border color here
                    width: 2.2, // Specify the border width here
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                        user.bgImg), // Provide the image path for each user
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: user.userName == "Manmeet" ||
                            user.userName == "Ritish" ||
                            user.userName == "Gurpreet"
                        ? Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.white,
                            size: 28,
                          )
                        : null),
              ),
              Text(
                user.userName,
                style: TextStyle(
                  fontFamily: "RobotoMono",
                  color: Colors.white,
                  fontWeight:
                      user.userName == "Ritish" ? FontWeight.w800 : null,
                  fontSize: 15.5,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );

    // ListView.builder(
    //     // scrollDirection: Axis.horizontal,
    //     itemCount: users.length,
    //     itemBuilder: (context, index) {
    //       return Container(
    //         width: 10,
    //         child: Text("hi"),
    //         // decoration: BoxDecoration(
    //         //     // image: DecorationImage(
    //         //     //   image: AssetImage("assets/profile.prof1.png"),
    //         //     //   fit: BoxFit.cover,
    //         //     // ),
    //         //     ),
    //       );
    //     });
  }
}
