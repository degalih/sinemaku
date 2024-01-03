part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends PopularMoviesState {}

class MoviesLoading extends PopularMoviesState {}

class MoviesHasData extends PopularMoviesState {
  final List<Movie> movies;

  const MoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends PopularMoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}
