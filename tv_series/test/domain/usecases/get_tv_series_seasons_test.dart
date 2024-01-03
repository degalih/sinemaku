import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeasons usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesSeasons(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeason = 1;

  test('should get tv series season from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesSeasons(tId, tSeason))
        .thenAnswer((_) async => Right(testTvSeriesSeasons));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, Right(testTvSeriesSeasons));
  });
}
