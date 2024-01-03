import 'dart:convert';

import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
      popularity: 5937.584,
      id: 52814,
      backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
      voteAverage: 8.9,
      overview:
          'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
      firstAirDate: '2022-03-24',
      originCountry: ['US'],
      genreIds: [10759, 10765],
      originalLanguage: 'en',
      voteCount: 300,
      name: 'Halo',
      originalName: 'Halo');

  const tTvSeriesResponseModel =
      TvSeriesResponse(tvList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/on_the_air.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
            "first_air_date": "2022-03-24",
            "genre_ids": [10759, 10765],
            "id": 52814,
            "name": "Halo",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Halo",
            "overview":
                "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
            "popularity": 5937.584,
            "poster_path": "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
            "vote_average": 8.9,
            "vote_count": 300
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
