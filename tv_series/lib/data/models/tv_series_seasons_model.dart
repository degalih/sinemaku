import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_seasons.dart';

class TvSeriesSeasonsModel extends Equatable {
  const TvSeriesSeasonsModel({
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

  factory TvSeriesSeasonsModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonsModel(
        id: json["id"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
      };

  TvSeriesSeasons toEntity() {
    return TvSeriesSeasons(
      id: id,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        seasonNumber,
      ];
}

// ignore: must_be_immutable
class Episode extends Equatable {
  Episode({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  int episodeNumber;
  int id;
  String? name;
  String? overview;
  int seasonNumber;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
      };

  Episode toEntity() {
    return Episode(
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        seasonNumber: seasonNumber);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [episodeNumber, id, name, overview, seasonNumber];
}
