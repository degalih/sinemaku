import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/presentation/bloc/on_the_air/on_the_air_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  late OnTheAirTvSeriesBloc onTheAirTvSeriesBloc;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    onTheAirTvSeriesBloc = OnTheAirTvSeriesBloc(mockGetOnTheAirTvSeries);
  });

  test('initial state should be empty', () {
    expect(onTheAirTvSeriesBloc.state, TvSeriesEmpty());
  });

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return onTheAirTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      TvSeriesLoading(),
      TvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onTheAirTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      TvSeriesLoading(),
      const TvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );
}
