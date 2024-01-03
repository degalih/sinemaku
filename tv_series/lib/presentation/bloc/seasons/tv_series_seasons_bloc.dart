import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_seasons.dart';
import 'package:tv_series/domain/usecases/get_tv_series_seasons.dart';

part 'tv_series_seasons_event.dart';

part 'tv_series_seasons_state.dart';

class TvSeriesSeasonsBloc
    extends Bloc<TvSeriesSeasonsEvent, TvSeriesSeasonsState> {
  final GetTvSeriesSeasons _getTvSeriesSeasons;

  TvSeriesSeasonsBloc(this._getTvSeriesSeasons)
      : super(TvSeriesSeasonsEmpty()) {
    on<FetchTvSeriesSeasons>((event, emit) async {
      emit(TvSeriesSeasonsLoading());

      final result = await _getTvSeriesSeasons.execute(event.id, event.season);

      result.fold(
        (failure) => emit(TvSeriesSeasonsError(failure.message)),
        (data) => emit(
          TvSeriesSeasonsHasData(data),
        ),
      );
    });
  }
}
