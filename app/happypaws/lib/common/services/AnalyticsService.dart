import 'package:happypaws/common/services/BaseService.dart';

class AnalyticsService extends BaseService {
  AnalyticsService() : super("Analytics");

   Future<dynamic> getCountByPetType({int size = 10}) async {
    var response = await get('/GetCountByPetType');
    return response;
  }
}
