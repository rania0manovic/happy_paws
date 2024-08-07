import 'package:happypaws/common/services/BaseService.dart';

class PetBreedsService extends BaseService {
  PetBreedsService() : super("PetBreeds");

  Future<dynamic> getBreedsForPetType(String? petTypeId) async {
    final response = await get('/GetBreedsForPetType?petTypeId=$petTypeId');
    return response;
  }
}
