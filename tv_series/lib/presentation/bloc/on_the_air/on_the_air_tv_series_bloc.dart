import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';

part 'on_the_air_tv_series_event.dart';

part 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries _getOnTheAirTvSeries;

  OnTheAirTvSeriesBloc(this._getOnTheAirTvSeries) : super(TvSeriesEmpty()) {
    on<FetchOnTheAirTvSeries>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getOnTheAirTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesError(failure.message)),
        (data) => emit(
          TvSeriesHasData(data),
        ),
      );
    });
  }
}
