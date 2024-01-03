import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieLoading());

      final result = await _getMovieDetail.execute(event.id);

      result.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (data) => emit(
          MovieHasData(data),
        ),
      );
    });
  }
}
