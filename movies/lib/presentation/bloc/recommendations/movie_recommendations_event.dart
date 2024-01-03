part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationMovies extends MovieRecommendationsEvent {
  final int id;

  const FetchRecommendationMovies(this.id);

  @override
  List<Object> get props => [id];
}
