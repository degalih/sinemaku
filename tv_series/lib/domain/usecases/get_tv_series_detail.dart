import 'package:dartz/dartz.dart';

import 'package:core/utils/failure.dart';
import 'package:tv_series/tv_series.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
