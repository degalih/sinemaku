import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/tv_series_seasons_model.dart';

// ignore: must_be_immutable
class TvSeriesSeasons extends Equatable {
  const TvSeriesSeasons({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  final int id;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        seasonNumber,
      ];
}
