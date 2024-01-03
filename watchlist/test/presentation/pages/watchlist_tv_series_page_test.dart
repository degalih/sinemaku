import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:watchlist/watchlist.dart';

class FakeWatchlistTvSeriesEvent extends Fake implements WatchlistTvSeriesBloc {
}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

class FakeWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

void main() {
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvSeriesBloc;

  setUp(() {
    fakeWatchlistTvSeriesBloc = FakeWatchlistTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => fakeWatchlistTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvSeriesBloc.state).thenReturn(WatchlistLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(textFinder, findsWidgets);
  });
}
