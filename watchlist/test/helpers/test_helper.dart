import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
  MovieRemoteDataSource,
  TvSeriesRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
  DatabaseHelperTvSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
