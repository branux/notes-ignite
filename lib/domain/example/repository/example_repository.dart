import 'dart:convert';
import '../datasource/api_example_datasource.dart';
import '../model/example_model.dart';

class ExampleRepository {
  ApiExampleDatasource api = ApiExampleDatasource();

  Future<ExampleModel> examplePost({required ExampleModel sendExample}) async {
    try {
      String response = await api.examplePost(sendExample: sendExample);
      Map<String, dynamic> responseMap = jsonDecode(response);

      if (responseMap["status"] == "OK") {
        ExampleModel example = ExampleModel.fromMap(responseMap);
        return example;
      } else {
        throw (responseMap);
      }
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    api.dispose();
  }
}
