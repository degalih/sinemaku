import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:watchlist/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  WatchlistTvSeriesBloc,
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListStatusTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
  });
  test('initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistEmpty());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should emit Loading, HasData when data is gotten succesfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData(testTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should emit Loading, HasData when data is unsuccessfully loaded',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return message when data added',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist TV Series'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(testTvSeriesDetail)),
    expect: () => [
      const IsAddedToWatchListTvSeries(true, 'Added to Watchlist TV Series')
    ],
    verify: (bloc) =>
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return message when data removed',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Removed to Watchlist TV Series'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(testTvSeriesDetail)),
    expect: () => [
      const IsAddedToWatchListTvSeries(false, 'Removed to Watchlist TV Series')
    ],
    verify: (bloc) =>
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return true when status loaded',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(1))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const GetWatchlistStatusEvent(1)),
    expect: () => [const IsAddedToWatchListTvSeries(true, '')],
    verify: (bloc) => verify(mockGetWatchListStatusTvSeries.execute(1)),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return failure message when data added',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(testTvSeriesDetail)),
    expect: () => [const IsAddedToWatchListTvSeries(false, 'Server Failure')],
    verify: (bloc) =>
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)),
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return failure message when data removed',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(testTvSeriesDetail)),
    expect: () => [const IsAddedToWatchListTvSeries(true, 'Server Failure')],
    verify: (bloc) =>
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)),
  );
}
