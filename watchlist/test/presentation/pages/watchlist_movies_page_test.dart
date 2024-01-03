import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:watchlist/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:watchlist/watchlist.dart';

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMoviesBloc {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

class FakeWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

void main() {
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;

  setUp(() {
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => fakeWatchlistMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state).thenReturn(WatchlistLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const WatchlistHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(const WatchlistError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistPage()));

    expect(textFinder, findsWidgets);
  });
}
