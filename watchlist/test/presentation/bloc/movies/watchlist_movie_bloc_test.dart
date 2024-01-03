import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/movies/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/movies/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/movies/save_watchlist.dart';
import 'package:watchlist/presentation/bloc/movies/watchlist_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  WatchlistMoviesBloc,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WatchlistEmpty());
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should emit Loading, HasData when data is gotten succesfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should emit Loading, HasData when data is unsuccessfully loaded',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should return message when data added',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(testMovieDetail)),
    expect: () => [const IsAddedToWatchListMovie(true, 'Added to Watchlist')],
    verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should return message when data removed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed to Watchlist'));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(testMovieDetail)),
    expect: () =>
        [const IsAddedToWatchListMovie(false, 'Removed to Watchlist')],
    verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should return true when status loaded',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(const GetWatchlistStatusEvent(1)),
    expect: () => [const IsAddedToWatchListMovie(true, '')],
    verify: (bloc) => verify(mockGetWatchListStatus.execute(1)),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should return failure message when data added',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(testMovieDetail)),
    expect: () => [const IsAddedToWatchListMovie(false, 'Server Failure')],
    verify: (bloc) => verify(mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'should return failure message when data removed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(testMovieDetail)),
    expect: () => [const IsAddedToWatchListMovie(true, 'Server Failure')],
    verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
  );
}
