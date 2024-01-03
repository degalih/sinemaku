import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      posterPath: 'posterPath',
      popularity: 1,
      id: 1,
      backdropPath: 'backdropPath',
      voteAverage: 1,
      overview: 'overview',
      firstAirDate: 'firstAirDate',
      originCountry: ['originCountry', 'originCountry2', 'originCountry3'],
      genreIds: [1, 2, 3],
      originalLanguage: 'originalLanguage',
      voteCount: 1,
      name: 'name',
      originalName: 'originalName');

  final tTvSeries = Tv(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: const [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: const [
        'originCountry',
        'originCountry2',
        'originCountry3'
      ],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of TV Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
