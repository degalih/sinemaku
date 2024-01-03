part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMoviesEvent extends WatchlistMoviesEvent {}

class GetWatchlistStatusEvent extends WatchlistMoviesEvent {
  final int id;

  const GetWatchlistStatusEvent(this.id);
}

class SaveWatchlistEvent extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const SaveWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistEvent extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const RemoveWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}
