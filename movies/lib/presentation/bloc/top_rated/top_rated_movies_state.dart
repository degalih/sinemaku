part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends TopRatedMoviesState {}

class MoviesLoading extends TopRatedMoviesState {}

class MoviesHasData extends TopRatedMoviesState {
  final List<Movie> movies;

  const MoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends TopRatedMoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}
