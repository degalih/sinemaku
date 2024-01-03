import 'package:flutter/material.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_series_page.dart';

class WatchlistPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
                text: "Movies",
              ),
              Tab(
                icon: Icon(Icons.tv_rounded),
                text: "Tv Series",
              ),
            ],
          ),
          title: const Text('Watchlist Ditonton'),
        ),
        body: const TabBarView(
          children: [WatchlistMoviesPage(), WatchlistTvSeriesPage()],
        ),
      ),
    );
  }
}
