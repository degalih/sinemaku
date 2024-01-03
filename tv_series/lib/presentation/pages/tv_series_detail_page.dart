import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendations/tv_series_recommendations_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_season_expandable%20list.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';

import '../../domain/entities/tv_series_detail.dart';

class TvSeriesDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/tv-series/detail';

  final int id;

  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(FetchTvSeriesDetail(widget.id));
      context
          .read<TvSeriesRecommendationsBloc>()
          .add(FetchRecommendationTvSeries(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(GetWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesHasData) {
            final tv = state.tv;
            return SafeArea(
              child: DetailContent(tv),
            );
          } else if (state is TvSeriesError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;

  const DetailContent(this.tvSeriesDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistTvSeriesBloc,
                                WatchlistTvSeriesState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (state is IsAddedToWatchListTvSeries) {
                                      if (!state.isAdded) {
                                        context
                                            .read<WatchlistTvSeriesBloc>()
                                            .add(SaveWatchlistEvent(
                                                tvSeriesDetail));
                                      } else {
                                        context
                                            .read<WatchlistTvSeriesBloc>()
                                            .add(RemoveWatchlistEvent(
                                                tvSeriesDetail));
                                      }
                                    }
                                    String message = "";
                                    if (state is IsAddedToWatchListTvSeries) {
                                      final isAdded = state.isAdded;
                                      message = isAdded == false
                                          ? watchlistAddSuccessMessage
                                          : watchlistRemoveSuccessMessage;
                                    }
                                    if (message == watchlistAddSuccessMessage ||
                                        message ==
                                            watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state is IsAddedToWatchListTvSeries
                                          ? (state.isAdded
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add))
                                          : Container(),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Text(
                              "Number of Episodes: " +
                                  tvSeriesDetail.numberOfEpisodes.toString(),
                            ),
                            Text(
                              "Number of Seasons: " +
                                  tvSeriesDetail.numberOfSeasons.toString(),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            TvSeriesSeasonExpandableList(
                                tvId: tvSeriesDetail.id,
                                seasonId: tvSeriesDetail.numberOfSeasons),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendationsBloc,
                                TvSeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationsError) {
                                  return Text(state.message);
                                } else if (state
                                    is TvSeriesRecommendationsHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.tv[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tv.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

// String _showDuration(int runtime) {
//   final int hours = runtime ~/ 60;
//   final int minutes = runtime % 60;
//
//   if (hours > 0) {
//     return '${hours}h ${minutes}m';
//   } else {
//     return '${minutes}m';
//   }
// }
}
