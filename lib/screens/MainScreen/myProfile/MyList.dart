// import 'package:flutter/material.dart';
// import 'package:netflix_clone/common/utils.dart';
// import 'package:netflix_clone/models/movie.dart';
// import 'package:netflix_clone/models/movie_model.dart';
// import 'package:netflix_clone/screens/movie_detailed_screen.dart';
// import 'package:netflix_clone/widgets/movieListProvider.dart';
// // import 'package:netflix_clone/widgets/movie_list_provider.dart';

// class MyListPersonlised extends StatelessWidget {
//   final Future<MovieList> future;
//   final String headlineText;
//   final MovieListProvider movieListProvider; // Add MovieListProvider parameter

//   const MyListPersonlised ({
//     Key? key,
//     required this.future,
//     required this.headlineText,
//     required this.movieListProvider,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<MovieModel>(
//       future: future,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var data = snapshot.data?.results;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 headlineText,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: data!.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MovieDetailScreen(
//                                 movieId: data[index].id,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: GestureDetector(
//                             onTap: () {
//                               // Add movie to the list
//                               movieListProvider.addToMyList(MovieList(
//                                 id: data[index].id,
//                                 title: data[index].title,
//                                 posterPath: data[index].posterPath,
//                               ));
//                             },
//                             child: Image.network(
//                               '$imageUrl${data[index].posterPath}',
//                               fit: BoxFit.fitHeight,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }
