import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/config/config_model.dart';
// import 'package:invapp/models/config/config_model.dart';
import 'package:invapp/models/config/config_response_model.dart';

class ConfigService {
  Future<Config> getAppConfig() async {
    try {
      final resp = await http.get(Uri.parse('${Enviroments.apiUrl}/config'), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return null;
      final configResponse = ConfigResponse.fromJson(json.decode(resp.body));
      return configResponse.data[0];
    } catch (e) {
      print(e);
      return null;
    }
  }
}
