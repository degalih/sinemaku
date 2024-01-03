import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/recommendations/tv_series_recommendations_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationsBloc tvSeriesRecommendationsBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationsBloc =
        TvSeriesRecommendationsBloc(mockGetTvSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(tvSeriesRecommendationsBloc.state, TvSeriesRecommendationsEmpty());
  });

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(1)),
    expect: () => [
      TvSeriesRecommendationsLoading(),
      TvSeriesRecommendationsHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );

  blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(1)),
    expect: () => [
      TvSeriesRecommendationsLoading(),
      const TvSeriesRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );
}
