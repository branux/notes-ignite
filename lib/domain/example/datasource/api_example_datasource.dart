import 'dart:convert';
import 'package:http/http.dart' show Client;
import '/domain/example/model/example_model.dart';

import '../../../core/core.dart';

class ApiExampleDatasource {
  Client client = Client();
  String server = UtilsConst.server;
  String acao = "example";

  Future<String> examplePost({required ExampleModel sendExample}) async {
    final response = await client.post(
      Uri.parse(server),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'acao': acao,
        'example': sendExample.example,
        'versao': VersionInfo().versionInfo.buildNumber,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Erro na conexão example (Status: ${response.statusCode} )");
    }
  }

  void dispose() {
    client.close();
  }
}
