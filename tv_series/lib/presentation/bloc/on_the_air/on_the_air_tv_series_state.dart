part of 'on_the_air_tv_series_bloc.dart';

abstract class OnTheAirTvSeriesState extends Equatable {
  const OnTheAirTvSeriesState();

  @override
  List<Object> get props => [];
}

class TvSeriesEmpty extends OnTheAirTvSeriesState {}

class TvSeriesLoading extends OnTheAirTvSeriesState {}

class TvSeriesHasData extends OnTheAirTvSeriesState {
  final List<Tv> tv;

  const TvSeriesHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvSeriesError extends OnTheAirTvSeriesState {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
