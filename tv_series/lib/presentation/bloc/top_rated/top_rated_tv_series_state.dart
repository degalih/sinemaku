part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TvSeriesEmpty extends TopRatedTvSeriesState {}

class TvSeriesLoading extends TopRatedTvSeriesState {}

class TvSeriesHasData extends TopRatedTvSeriesState {
  final List<Tv> tv;

  const TvSeriesHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvSeriesError extends TopRatedTvSeriesState {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
