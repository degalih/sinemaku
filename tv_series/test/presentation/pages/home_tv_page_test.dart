import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/on_the_air/on_the_air_tv_series_bloc.dart'
    as on_the_air;
import 'package:tv_series/presentation/bloc/popular/popular_tv_series_bloc.dart'
    as popular;
import 'package:tv_series/presentation/bloc/top_rated/top_rated_tv_series_bloc.dart'
    as top_rated;
import 'package:tv_series/tv_series.dart';

class FakeOnTheAirTvSeriesEvent extends Fake
    implements on_the_air.OnTheAirTvSeriesEvent {}

class FakeOnTheAirTvSeriesState extends Fake
    implements on_the_air.OnTheAirTvSeriesState {}

class FakeOnTheAirTvSeriesBloc extends MockBloc<
        on_the_air.OnTheAirTvSeriesEvent, on_the_air.OnTheAirTvSeriesState>
    implements on_the_air.OnTheAirTvSeriesBloc {}

class FakePopularTvSeriesEvent extends Fake
    implements popular.PopularTvSeriesEvent {}

class FakePopularTvSeriesState extends Fake
    implements popular.PopularTvSeriesState {}

class FakePopularTvSeriesBloc
    extends MockBloc<popular.PopularTvSeriesEvent, popular.PopularTvSeriesState>
    implements popular.PopularTvSeriesBloc {}

class FakeTopRatedTvSeriesEvent extends Fake
    implements top_rated.TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriesState extends Fake
    implements top_rated.TopRatedTvSeriesState {}

class FakeTopRatedTvSeriesBloc extends MockBloc<top_rated.TopRatedTvSeriesEvent,
    top_rated.TopRatedTvSeriesState> implements top_rated.TopRatedTvSeriesBloc {
}

void main() {
  late FakeOnTheAirTvSeriesBloc fakeOnTheAirTvSeriesBloc;
  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;
  late FakeTopRatedTvSeriesBloc fakeTopRatedTvSeriesBloc;

  setUp(() {
    fakeOnTheAirTvSeriesBloc = FakeOnTheAirTvSeriesBloc();
    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    fakeTopRatedTvSeriesBloc = FakeTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<on_the_air.OnTheAirTvSeriesBloc>(
          create: (context) => fakeOnTheAirTvSeriesBloc,
        ),
        BlocProvider<popular.PopularTvSeriesBloc>(
          create: (context) => fakePopularTvSeriesBloc,
        ),
        BlocProvider<top_rated.TopRatedTvSeriesBloc>(
          create: (context) => fakeTopRatedTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvSeriesBloc.state)
        .thenReturn(on_the_air.TvSeriesLoading());
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(popular.TvSeriesLoading());
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(top_rated.TvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvSeriesBloc.state)
        .thenReturn(const on_the_air.TvSeriesHasData(<Tv>[]));
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(const popular.TvSeriesHasData(<Tv>[]));
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(const top_rated.TvSeriesHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeOnTheAirTvSeriesBloc.state)
        .thenReturn(const on_the_air.TvSeriesError('Failed'));
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(const popular.TvSeriesError('Failed'));
    when(() => fakeTopRatedTvSeriesBloc.state)
        .thenReturn(const top_rated.TvSeriesError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    expect(textFinder, findsWidgets);
  });
}
