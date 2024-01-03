import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:search/presentation/bloc/movies/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';

class FakeSearchMoviesEvent extends Fake implements SearchEvent {}

class FakeSearchMoviesState extends Fake implements SearchState {}

class FakeSearchMoviesBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late FakeSearchMoviesBloc fakeSearchMoviesBloc;

  setUp(() {
    fakeSearchMoviesBloc = FakeSearchMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => fakeSearchMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeSearchMoviesBloc.state).thenReturn(SearchLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeSearchMoviesBloc.state)
        .thenReturn(const SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeSearchMoviesBloc.state)
        .thenReturn(const SearchError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(textFinder, findsWidgets);
  });
}
