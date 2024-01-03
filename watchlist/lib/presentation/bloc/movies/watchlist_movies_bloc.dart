import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:watchlist/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/movies/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/movies/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/movies/save_watchlist.dart';

part 'watchlist_movies_event.dart';

part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchlistStatus;
  final SaveWatchlist _saveWatchlistMovies;
  final RemoveWatchlist _removeWatchlistMovies;

  WatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._getWatchlistStatus,
    this._saveWatchlistMovies,
    this._removeWatchlistMovies,
  ) : super(WatchlistEmpty()) {
    on<GetWatchlistMoviesEvent>(
      (event, emit) async => _getWatchlist(event, emit),
    );
    on<GetWatchlistStatusEvent>(
      (event, emit) async => _getStatus(event, emit),
    );
    on<SaveWatchlistEvent>(
      (event, emit) async => _saveWatchlist(event, emit),
    );
    on<RemoveWatchlistEvent>(
      (event, emit) async => _removeWatchlist(event, emit),
    );
  }

  Future<void> _getWatchlist(
    GetWatchlistMoviesEvent event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(WatchlistLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(WatchlistEmpty());
        } else {
          emit(WatchlistHasData(data));
        }
      },
    );
  }

  Future<void> _saveWatchlist(
    SaveWatchlistEvent event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final result = await _saveWatchlistMovies.execute(event.movie);

    result.fold(
      (failure) {
        emit(IsAddedToWatchListMovie(false, failure.message));
      },
      (data) {
        emit(
          IsAddedToWatchListMovie(true, data),
        );
      },
    );
  }

  Future<void> _removeWatchlist(
    RemoveWatchlistEvent event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final result = await _removeWatchlistMovies.execute(event.movie);

    result.fold(
      (failure) {
        emit(IsAddedToWatchListMovie(true, failure.message));
      },
      (data) {
        emit(
          IsAddedToWatchListMovie(false, data),
        );
      },
    );
  }

  Future<void> _getStatus(
    GetWatchlistStatusEvent event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final result = await _getWatchlistStatus.execute(event.id);
    emit(IsAddedToWatchListMovie(result, ''));
  }
}
