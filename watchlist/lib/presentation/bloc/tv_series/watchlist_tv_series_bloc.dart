import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:watchlist/domain/usecases/tv_series/remove_watchlist_tv_series.dart';

import '../../../domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import '../../../domain/usecases/tv_series/get_watchlist_tv_series.dart';
import '../../../domain/usecases/tv_series/save_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetWatchListStatusTvSeries _getWatchlistStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  WatchlistTvSeriesBloc(
    this._getWatchlistTvSeries,
    this._getWatchlistStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  ) : super(WatchlistEmpty()) {
    on<GetWatchlistTvSeriesEvent>(
      (event, emit) async => _getWatchlist(event, emit),
    );
    on<GetWatchlistStatusEvent>(
      (event, emit) async => _getStatus(event, emit),
    );
    on<SaveWatchlistEvent>(
      (event, emit) async => _saveWatchlist(event, emit),
    );
    on<RemoveWatchlistEvent>(
      (event, emit) async => _removeWatchlist(event, emit),
    );
  }

  Future<void> _getWatchlist(
    GetWatchlistTvSeriesEvent event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    emit(WatchlistLoading());

    final result = await _getWatchlistTvSeries.execute();

    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(WatchlistEmpty());
        } else {
          emit(WatchlistHasData(data));
        }
      },
    );
  }

  Future<void> _saveWatchlist(
    SaveWatchlistEvent event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final result = await _saveWatchlistTvSeries.execute(event.tv);

    result.fold(
      (failure) {
        emit(IsAddedToWatchListTvSeries(false, failure.message));
      },
      (data) {
        emit(
          IsAddedToWatchListTvSeries(true, data),
        );
      },
    );
  }

  Future<void> _removeWatchlist(
    RemoveWatchlistEvent event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final result = await _removeWatchlistTvSeries.execute(event.tv);

    result.fold(
      (failure) {
        emit(IsAddedToWatchListTvSeries(true, failure.message));
      },
      (data) {
        emit(
          IsAddedToWatchListTvSeries(false, data),
        );
      },
    );
  }

  Future<void> _getStatus(
    GetWatchlistStatusEvent event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    final result = await _getWatchlistStatusTvSeries.execute(event.id);
    emit(IsAddedToWatchListTvSeries(result, ''));
  }
}
