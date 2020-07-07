// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestApiClient implements RestApiClient {
  _RestApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getRunningTournaments() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request(
        '/running?token=mR4uAC_4wM-IhISLMUin4OTZT2tIBgBk1PxRGTikPHGgROpoBRk',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  getUpcomingTournaments() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request(
        '/upcoming?token=mR4uAC_4wM-IhISLMUin4OTZT2tIBgBk1PxRGTikPHGgROpoBRk',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  showPlatformList(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/platforms?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PlatformList.fromJson(_result.data);
    return value;
  }

  @override
  showPlatformDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/platforms/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PlatformDescription.fromJson(_result.data);
    return value;
  }

  @override
  showPlatformWiseGamesWithFilter(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?ordering={ordering}&page=$no&platforms=$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedPlatforms(userAgent, gameName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(gameName, 'gameName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/platforms?search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PlatformList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedGames(userAgent, gameName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(gameName, 'gameName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?search=$gameName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  allGamesForSearch(userAgent) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=1&limit=365811',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGames(userAgent, no, ordering, platformId) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(ordering, 'ordering');
    ArgumentError.checkNotNull(platformId, 'platformId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&ordering=$ordering&platforms=$platformId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesSeries(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games/$id/game-series',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesSuggested(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games/$id/suggested?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesTrailers(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request('/games/$id/movies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  showMonthWiseGameRelease(userAgent, dates, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(dates, 'dates');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?dates=$dates&ordering=-added&page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  getGameDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameListDetails.fromJson(_result.data);
    return value;
  }

  @override
  getGameYoutubeVideos(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request('/games/$id/youtube',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  showPlatformWiseGameList(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?platforms=$id&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showPublisherList(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/publishers?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GamePublisherPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showGamePublishersDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/publishers/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GamePublisherDetails.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesByPublishers(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&publishers=$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedPublisher(publisherName) async {
    ArgumentError.checkNotNull(publisherName, 'publisherName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/publishers?search=$publisherName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GamePublisherPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showGenresList(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/genres?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GenresPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showGameGenresDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/genres/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameGenresDetails.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesByGenres(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&genres=$id&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedGenres(userAgent, genresName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(genresName, 'genresName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/genres?search=$genresName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GenresPOJO.fromJson(_result.data);
    return value;
  }

  @override
  shoeGameStores(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/stores?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameStores.fromJson(_result.data);
    return value;
  }

  @override
  showGameStoreDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/stores/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameStoreDetails.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesByStores(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&stores=$id&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedStore(userAgent, storeName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(storeName, 'storeName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/stores?search=$storeName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameStores.fromJson(_result.data);
    return value;
  }

  @override
  showGameCreators(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/creators?page=$no&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameCreatorsPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showGameCreatorsDetails(userAgent, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/creators/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GamesCreatorsDetails.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesByCreators(userAgent, id, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&creators=$id&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedCreator(userAgent, creatorsName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(creatorsName, 'creatorsName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/creators?search=$creatorsName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameCreatorsPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showGameTags(userAgent, no) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/tags?page=$no',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameTagsPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showListOfGamesByTags(userAgent, no, id) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(no, 'no');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?page=$no&tags=$id&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }

  @override
  showSearchedTags(userAgent, tagName) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(tagName, 'tagName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/tags?search=$tagName',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameTagsPOJO.fromJson(_result.data);
    return value;
  }

  @override
  showWeeklyRelease(userAgent, start) async {
    ArgumentError.checkNotNull(userAgent, 'userAgent');
    ArgumentError.checkNotNull(start, 'start');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/games?dates=$start&ordering=-added',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'User-agent': userAgent},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GameList.fromJson(_result.data);
    return value;
  }
}
