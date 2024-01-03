import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? firstAirDate;
  List<String>? originCountry;
  List<int>? genreIds;
  String? backdropPath;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  double? popularity;
  double? voteAverage;
  int id;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
