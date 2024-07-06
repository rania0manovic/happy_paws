import 'package:happypaws/common/services/BaseService.dart';

class PetsService extends BaseService {
  PetsService() : super("Pets");

  Future<dynamic> hasAnyWithPetBreedId(int breedId) async {
    var response = await get('/HasAnyWithPetBreedId/$breedId');
    return response;
  }

  Future<dynamic> hasAnyWithPetTypeId(int typeId) async {
    var response = await get('/HasAnyWithPetTypeId/$typeId');
    return response;
  }

 
}
