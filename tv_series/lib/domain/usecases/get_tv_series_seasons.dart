import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

class GetTvSeriesSeasons {
  final TvSeriesRepository repository;

  GetTvSeriesSeasons(this.repository);

  Future<Either<Failure, TvSeriesSeasons>> execute(id, season) {
    return repository.getTvSeriesSeasons(id, season);
  }
}
