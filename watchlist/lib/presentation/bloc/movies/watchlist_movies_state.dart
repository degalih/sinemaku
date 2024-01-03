part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistMoviesState {}

class WatchlistLoading extends WatchlistMoviesState {}

class WatchlistError extends WatchlistMoviesState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class IsAddedToWatchListMovie extends WatchlistMoviesState {
  final bool isAdded;
  final String message;

  const IsAddedToWatchListMovie(this.isAdded, this.message);

  @override
  List<Object> get props => [isAdded, message];
}
