import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/on_the_air_tv_series_page.dart';

class FakeOnTheAirTvSeriesEvent extends Fake implements OnTheAirTvSeriesEvent {}

class FakeOnTheAirTvSeriesState extends Fake implements OnTheAirTvSeriesState {}

class FakeOnTheAirTvSeriesBloc
    extends MockBloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState>
    implements OnTheAirTvSeriesBloc {}

void main() {
  late FakeOnTheAirTvSeriesBloc fake;

  setUp(() {
    fake = FakeOnTheAirTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<OnTheAirTvSeriesBloc>(
          create: (context) => fake,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fake.state).thenReturn(TvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fake.state).thenReturn(const TvSeriesHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fake.state).thenReturn(const TvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
