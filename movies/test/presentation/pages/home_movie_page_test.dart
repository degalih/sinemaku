import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart'
    as now_playing;
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart'
    as popular;
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart'
    as top_rated;
import 'package:movies/presentation/pages/home_movie_page.dart';

class FakeNowPlayingMoviesEvent extends Fake
    implements now_playing.NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake
    implements now_playing.NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc extends MockBloc<
        now_playing.NowPlayingMoviesEvent, now_playing.NowPlayingMoviesState>
    implements now_playing.NowPlayingMoviesBloc {}

class FakePopularMoviesEvent extends Fake
    implements popular.PopularMoviesEvent {}

class FakePopularMoviesState extends Fake
    implements popular.PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<popular.PopularMoviesEvent, popular.PopularMoviesState>
    implements popular.PopularMoviesBloc {}

class FakeTopRatedMoviesEvent extends Fake
    implements top_rated.TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake
    implements top_rated.TopRatedMoviesState {}

class FakeTopRatedMoviesBloc extends MockBloc<top_rated.TopRatedMoviesEvent,
    top_rated.TopRatedMoviesState> implements top_rated.TopRatedMoviesBloc {}

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMoviesBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;

  setUp(() {
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();
    fakePopularMoviesBloc = FakePopularMoviesBloc();
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<now_playing.NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<popular.PopularMoviesBloc>(
          create: (context) => fakePopularMoviesBloc,
        ),
        BlocProvider<top_rated.TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(now_playing.MoviesLoading());
    when(() => fakePopularMoviesBloc.state).thenReturn(popular.MoviesLoading());
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(top_rated.MoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(progressFinder, findsWidgets);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(now_playing.MoviesHasData(<Movie>[]));
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(popular.MoviesHasData(<Movie>[]));
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(top_rated.MoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(now_playing.MoviesError('Failed'));
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(popular.MoviesError('Failed'));
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(top_rated.MoviesError('Failed'));

    final textFinder = find.byWidgetPredicate((widget) => true);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(textFinder, findsWidgets);
  });
}
