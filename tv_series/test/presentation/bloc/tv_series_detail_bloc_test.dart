import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvSeriesEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesDetail(1)),
    expect: () => [
      TvSeriesLoading(),
      TvSeriesHasData(testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesDetail(1)),
    expect: () => [
      TvSeriesLoading(),
      const TvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );
}
