import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

// TV Series
const testTvSeriesTable = TvSeriesTable(
  id: 1402,
  name: 'The Walking Dead',
  posterPath: '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
);

final testTvSeriesMap = {
  'id': 1402,
  'name': 'The Walking Dead',
  'posterPath': '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
  'overview':
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
};

final testTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: '/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg',
    genres: [
      Genre(id: 10759, name: 'Action & Adventure'),
      Genre(id: 18, name: 'Drama'),
      Genre(id: 10765, name: 'Sci-Fi & Fantasy'),
    ],
    id: 1402,
    name: 'The Walking Dead',
    numberOfEpisodes: 177,
    numberOfSeasons: 11,
    overview:
        "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
    popularity: 1672.139,
    posterPath: '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
    voteAverage: 8.1,
    voteCount: 12836);

final testWatchlistTvSeries = Tv.watchlist(
  id: 1402,
  name: 'The Walking Dead',
  posterPath: '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
);

final testTvSeries = Tv(
    backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
    firstAirDate: '2022-03-24',
    genreIds: const [10759, 10765],
    id: 52814,
    name: 'Halo',
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    popularity: 5937.584,
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
    voteAverage: 8.9,
    voteCount: 300);

final testTvSeriesSeasons = TvSeriesSeasons(
  id: 1,
  episodes: [
    Episode(
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        seasonNumber: 1),
    Episode(
        episodeNumber: 2,
        id: 2,
        name: 'name 2',
        overview: 'overview ',
        seasonNumber: 2),
  ],
  name: 'name',
  overview: 'overview',
  seasonNumber: 1,
);

final testTvSeriesList = [testTvSeries];
