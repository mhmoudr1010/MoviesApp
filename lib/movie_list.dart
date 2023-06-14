import 'package:flutter/material.dart';

import 'package:movies/movie.dart';

import 'movie_details.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text("Movies");

  final String iconBase = "https://image.tmdb.org/t/p/w92";
  final String defaultImage =
      "https://www.istockphoto.com/photo/blank-movie-clapper-3d-isolated-illustration-gm893853364-247214231";

  late HttpHelper helper;

  int? moviesCount;
  List<Movie>? movies;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    onSubmitted: (text) {
                      search(text);
                    },
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text("Movies");
                    initialize();
                  });
                }
              });
            },
            icon: visibleIcon,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: (context, index) {
          image = NetworkImage(iconBase + movies![index].posterPath);
          // itemBuilder,
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetail(movie: movies![index]),
                );
                Navigator.push(context, route);
              },
              leading: CircleAvatar(
                backgroundImage: (image == null)
                    ? const NetworkImage(
                        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fnetwork&psig=AOvVaw03ydDUZgV_RPS8EGkTlP0S&ust=1673894585623000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMC9z7qdyvwCFQAAAAAdAAAAABAE")
                    : image,
              ),
              title: Text(movies![index].title),
              subtitle: Text(
                  "Released: ${movies?[index].releaseDate} - Rating: ${movies?[index].voteAverage}"),
            ),
          );
        },
      ),
    );
  }

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies?.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies?.length;
      movies = movies;
    });
  }
}
