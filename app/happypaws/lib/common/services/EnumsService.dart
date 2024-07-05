import 'package:happypaws/common/services/BaseService.dart';

class EnumsService extends BaseService {
  EnumsService() : super("Enums");

  Future<dynamic> getEmployeePositions() async {
    return await get("/GetEmployeePositions");
  }
   Future<dynamic> getOrderStatuses() async {
    return await get("/GetOrderStatuses");
  }
  Future<dynamic> getNewsletterTopics() async {
    return await get("/GetNewsletterTopics");
  }
}
