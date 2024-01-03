import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_bloc.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/tv.dart';

class FakeSearchTvSeriesEvent extends Fake implements SearchTvSeriesEvent {}

class FakeSearchTvSeriesState extends Fake implements SearchTvSeriesState {}

class FakeSearchTvSeriesBloc
    extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

void main() {
  late FakeSearchTvSeriesBloc fakeSearchTvSeriesBloc;

  setUp(() {
    fakeSearchTvSeriesBloc = FakeSearchTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchTvSeriesBloc>(
          create: (context) => fakeSearchTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(const SearchTvSeriesPage()));

    expect(textFinder, findsWidgets);
  });
}
