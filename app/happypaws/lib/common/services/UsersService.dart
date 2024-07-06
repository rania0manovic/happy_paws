import 'package:happypaws/common/services/BaseService.dart';


class UsersService extends BaseService {
  UsersService() : super("Users");

  Future<dynamic> getRecommendedProducts() async {
    var response = await get('/RecommendedProducts');
    return response;
  }

   Future<dynamic> subscribeToNewsletter() async {
    var response = await patch('/SubscribeToNewsletter', null);
    return response;
  }
}
