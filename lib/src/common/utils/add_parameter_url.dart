import 'package:api_fake_storage_orm/src/common/enum/sort.dart';

class AddParametersURL {

  static String addSortToUrl(String url, Sort? sort) {

    if (sort == null) {
      return url;
    }

    Uri uri = Uri.parse(url);
    String sortParam = sort == Sort.asc ? 'asc' : 'desc';
    Uri updatedUri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'sort': sortParam,
    });
    return updatedUri.toString();
  }

  static String addLimitToUrl(String url, int? limit) {

    if (limit == null) {
      return url;
    }

    Uri uri = Uri.parse(url);
    Uri updatedUri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'limit': limit.toString(),
    });
    return updatedUri.toString();
  }

}