import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';
import 'package:tv_series/presentation/bloc/seasons/tv_series_seasons_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_seasons_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesSeasons])
void main() {
  late TvSeriesSeasonsBloc tvSeriesSeasonsBloc;
  late MockGetTvSeriesSeasons mockGetTvSeriesSeasons;

  setUp(() {
    mockGetTvSeriesSeasons = MockGetTvSeriesSeasons();
    tvSeriesSeasonsBloc = TvSeriesSeasonsBloc(mockGetTvSeriesSeasons);
  });

  test('initial state should be empty', () {
    expect(tvSeriesSeasonsBloc.state, TvSeriesSeasonsEmpty());
  });

  blocTest<TvSeriesSeasonsBloc, TvSeriesSeasonsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesSeasons.execute(1, 1))
          .thenAnswer((_) async => Right(testTvSeriesSeasons));
      return tvSeriesSeasonsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesSeasons(1, 1)),
    expect: () => [
      TvSeriesSeasonsLoading(),
      TvSeriesSeasonsHasData(testTvSeriesSeasons),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesSeasons.execute(1, 1));
    },
  );

  blocTest<TvSeriesSeasonsBloc, TvSeriesSeasonsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetTvSeriesSeasons.execute(1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSeasonsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesSeasons(1, 1)),
    expect: () => [
      TvSeriesSeasonsLoading(),
      const TvSeriesSeasonsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesSeasons.execute(1, 1));
    },
  );
}
