part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends NowPlayingMoviesState {}

class MoviesLoading extends NowPlayingMoviesState {}

class MoviesHasData extends NowPlayingMoviesState {
  final List<Movie> movies;

  const MoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends NowPlayingMoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}
