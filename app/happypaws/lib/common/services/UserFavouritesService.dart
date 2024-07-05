import 'package:happypaws/common/services/BaseService.dart';

class UserFavouritesService extends BaseService {
  UserFavouritesService() : super("UserFavourites");

  Future<dynamic> getPagedProducts(data) async {
    final response = await get("/GetPagedProducts", searchObject: data);
    return response;
  }
}
