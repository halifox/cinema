import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'cms_models.dart';

part 'cms_api.g.dart';

@RestApi(baseUrl: 'https://example.com')
abstract class CmsApi {
  factory CmsApi(Dio dio, {String? baseUrl}) = _CmsApi;

  @GET('/api.php/provide/vod/')
  Future<CmsResponseDto> categories({
    @Query('ac') String action = 'list',
    @Query('pg') int page = 1,
  });

  @GET('/api.php/provide/vod/at/json/')
  Future<CmsResponseDto> catalog({
    @Query('t') required int typeId,
    @Query('pg') required int page,
    @Query('ac') String action = 'detail',
  });

  @GET('/api.php/provide/vod/at/json/')
  Future<CmsResponseDto> search({
    @Query('wd') required String query,
    @Query('pg') required int page,
    @Query('ac') String action = 'detail',
  });

  @GET('/api.php/provide/vod/at/json/')
  Future<CmsResponseDto> detail({
    @Query('ids') required int id,
    @Query('ac') String action = 'detail',
  });
}
