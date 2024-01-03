import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvSeries();

  Future<Either<Failure, List<Tv>>> getPopularTvSeries();

  Future<Either<Failure, List<Tv>>> getTopRatedTvSeries();

  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);

  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendation(int id);

  Future<Either<Failure, TvSeriesSeasons>> getTvSeriesSeasons(
      int id, int season);

  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tvSeriesDetail);

  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tvSeriesDetail);

  Future<bool> isAddedToWatchlistTvSeries(int id);

  Future<Either<Failure, List<Tv>>> getWatchlistTvSeries();

  Future<Either<Failure, List<Tv>>> searchTvSeries(String query);
}
