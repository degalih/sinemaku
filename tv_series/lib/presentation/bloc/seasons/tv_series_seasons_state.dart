part of 'tv_series_seasons_bloc.dart';

abstract class TvSeriesSeasonsState extends Equatable {
  const TvSeriesSeasonsState();

  @override
  List<Object> get props => [];
}

class TvSeriesSeasonsEmpty extends TvSeriesSeasonsState {}

class TvSeriesSeasonsLoading extends TvSeriesSeasonsState {}

class TvSeriesSeasonsHasData extends TvSeriesSeasonsState {
  final TvSeriesSeasons tvSeason;

  const TvSeriesSeasonsHasData(this.tvSeason);

  @override
  List<Object> get props => [tvSeason];
}

class TvSeriesSeasonsError extends TvSeriesSeasonsState {
  final String message;

  const TvSeriesSeasonsError(this.message);

  @override
  List<Object> get props => [message];
}
