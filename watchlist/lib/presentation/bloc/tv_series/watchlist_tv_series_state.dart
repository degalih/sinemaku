part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistTvSeriesState {}

class WatchlistLoading extends WatchlistTvSeriesState {}

class WatchlistError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistTvSeriesState {
  final List<Tv> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class IsAddedToWatchListTvSeries extends WatchlistTvSeriesState {
  final bool isAdded;
  final String message;

  const IsAddedToWatchListTvSeries(this.isAdded, this.message);

  @override
  List<Object> get props => [isAdded, message];
}
