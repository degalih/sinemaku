part of 'tv_series_seasons_bloc.dart';

abstract class TvSeriesSeasonsEvent extends Equatable {
  const TvSeriesSeasonsEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesSeasons extends TvSeriesSeasonsEvent {
  final int id;
  final int season;

  const FetchTvSeriesSeasons(this.id, this.season);

  @override
  List<Object> get props => [id, season];
}
