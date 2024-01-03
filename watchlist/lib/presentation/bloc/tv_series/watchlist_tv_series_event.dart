part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {}

class GetWatchlistStatusEvent extends WatchlistTvSeriesEvent {
  final int id;

  const GetWatchlistStatusEvent(this.id);
}

class SaveWatchlistEvent extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tv;

  const SaveWatchlistEvent(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistEvent extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tv;

  const RemoveWatchlistEvent(this.tv);

  @override
  List<Object> get props => [tv];
}
