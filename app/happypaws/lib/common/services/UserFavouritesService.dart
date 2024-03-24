import 'package:happypaws/common/services/BaseService.dart';

class UserFavouritesService extends BaseService {
  UserFavouritesService() : super("UserFavourites");

  Future<dynamic> getPagedProducts(String userId) async {
    final response = await get("/GetPagedProducts?UserId=$userId");
    return response;
  }
}
