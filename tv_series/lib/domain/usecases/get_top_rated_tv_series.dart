import 'package:dartz/dartz.dart';

import 'package:core/utils/failure.dart';
import 'package:tv_series/tv_series.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
