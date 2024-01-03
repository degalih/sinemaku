import 'package:dartz/dartz.dart';

import 'package:core/utils/failure.dart';
import 'package:tv_series/tv_series.dart';

class GetOnTheAirTvSeries {
  final TvSeriesRepository repository;

  GetOnTheAirTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvSeries();
  }
}
