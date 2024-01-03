import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MoviesLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(MoviesError(failure.message)),
        (data) => emit(
          MoviesHasData(data),
        ),
      );
    });
  }
}
