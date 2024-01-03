import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelperTvSeries,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
