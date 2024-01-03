import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

import '../../../domain/entities/tv.dart';

part 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super(TvSeriesEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(
          TvSeriesHasData(data),
        ),
      );
    });
  }
}
