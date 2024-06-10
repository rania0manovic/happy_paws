import 'package:happypaws/common/services/BaseService.dart';
import 'package:http/http.dart' as http;

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

  @override
  Future<dynamic> post(String endpoint, data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl),
    );
    if (data['PhotoFile'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'PhotoFile',
          data["PhotoFile"],
        ),
      );
    }
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(String endpoint, data) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(baseUrl),
    );
    if (data['PhotoFile'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'PhotoFile',
          data["PhotoFile"],
        ),
      );
    }
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
