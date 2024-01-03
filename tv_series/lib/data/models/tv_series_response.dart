import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvList;

  const TvSeriesResponse({required this.tvList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvList: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvList];
}
