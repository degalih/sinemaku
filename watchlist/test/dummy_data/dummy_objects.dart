import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

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

final testTvSeriesList = [testTvSeries];
