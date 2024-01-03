import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

import '../../../domain/entities/tv.dart';

part 'top_rated_tv_series_event.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries) : super(TvSeriesEmpty()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getTopRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(
          TvSeriesHasData(data),
        ),
      );
    });
  }
}
