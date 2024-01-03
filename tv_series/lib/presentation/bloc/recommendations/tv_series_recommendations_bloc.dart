import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';

part 'tv_series_recommendations_event.dart';

part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsBloc
    extends Bloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;

  TvSeriesRecommendationsBloc(this._getTvSeriesRecommendations)
      : super(TvSeriesRecommendationsEmpty()) {
    on<FetchRecommendationTvSeries>((event, emit) async {
      emit(TvSeriesRecommendationsLoading());

      final result = await _getTvSeriesRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(TvSeriesRecommendationsError(failure.message)),
        (data) => emit(
          TvSeriesRecommendationsHasData(data),
        ),
      );
    });
  }
}
