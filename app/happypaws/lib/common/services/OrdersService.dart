import 'package:happypaws/common/services/BaseService.dart';

class OrdersService extends BaseService {
  OrdersService() : super("Orders");

  Future<dynamic> getTopBuyers({int size = 10}) async {
    var response = await get('/GetTopBuyers?size=$size');
    return response;
  }

  Future<dynamic> hasAnyByProductId(int productId) async {
    var response = await get('/HasAnyByProductId/$productId');
    return response;
  }
}
