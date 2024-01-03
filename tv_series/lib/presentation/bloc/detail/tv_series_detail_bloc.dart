import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';

part 'tv_series_detail_event.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesEmpty()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getTvSeriesDetail.execute(event.id);

      result.fold(
        (failure) => emit(
          TvSeriesError(failure.message),
        ),
        (data) => emit(
          TvSeriesHasData(data),
        ),
      );
    });
  }
}
