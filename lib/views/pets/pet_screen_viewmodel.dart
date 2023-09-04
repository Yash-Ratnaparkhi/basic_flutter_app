import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:test_project/modals/dog_breed.dart';
import 'package:test_project/utils/constants.dart';

class PetScreenViewModel extends BaseViewModel {
  final http.Client? httpClient;

  PetScreenViewModel({this.httpClient}) {
    fetchImages();
  }

  String _imageUrls = "";
  String get imageUrls => _imageUrls;

  Future<void> fetchImages() async {
    setBusy(true);
    try {
      final response = await http.get(Uri.parse(Constants.dogBreedApiKey));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final DogBreedList data = DogBreedList.fromJson(responseData);

        if (data.status == "success") {
          _imageUrls = data.message ?? "";
        } else {}
      } else {
        throw Exception('Failed to load images');
      }
    } catch (error) {
      // Handle error
    }

    setBusy(false);
  }
}
