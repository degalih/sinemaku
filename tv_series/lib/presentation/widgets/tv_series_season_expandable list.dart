// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:core/core.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/seasons/tv_series_seasons_bloc.dart';

class TvSeriesSeasonExpandableList extends StatefulWidget {
  final int tvId;
  final int seasonId;

  const TvSeriesSeasonExpandableList(
      {Key? key, required this.tvId, required this.seasonId})
      : super(key: key);

  @override
  State<TvSeriesSeasonExpandableList> createState() =>
      _TvSeriesSeasonExpandableListState();
}

class _TvSeriesSeasonExpandableListState
    extends State<TvSeriesSeasonExpandableList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<TvSeriesSeasonsBloc>()
          .add(FetchTvSeriesSeasons(widget.tvId, widget.seasonId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesSeasonsBloc, TvSeriesSeasonsState>(
      builder: (context, state) {
        if (state is TvSeriesSeasonsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeriesSeasonsError) {
          return Text(state.message);
        } else if (state is TvSeriesSeasonsHasData) {
          final tvSeason = state.tvSeason;
          return ExpandableNotifier(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: ScrollOnExpand(
                child: Card(
                  color: kGrey,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: true,
                          hasIcon: false,
                        ),
                        header: Container(
                          color: kMikadoYellow,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ExpandableIcon(
                                  theme: const ExpandableThemeData(
                                    expandIcon: Icons.arrow_right,
                                    collapseIcon: Icons.arrow_drop_down,
                                    iconColor: kRichBlack,
                                    iconSize: 28.0,
                                    iconRotationAngle: math.pi / 2,
                                    iconPadding: EdgeInsets.only(right: 5),
                                    hasIcon: false,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Season Terbaru: " +
                                        tvSeason.seasonNumber.toString(),
                                    style:
                                        kHeading6.copyWith(color: kRichBlack),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Column(
                          children: tvSeason.episodes.map((episode) {
                            return EpisodeCard(
                                name: episode.name,
                                overview: episode.overview,
                                episodeNumber: episode.episodeNumber);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final int episodeNumber;
  final String? name;
  final String? overview;

  const EpisodeCard(
      {Key? key,
      required this.name,
      required this.overview,
      required this.episodeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            color: kDavysGrey,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: kPrussianBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconRotationAngle: math.pi / 2,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Episode $episodeNumber: $name",
                              style: kSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: ListTile(
                    subtitle: Text(
                      overview ?? 'overview not available:(',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
