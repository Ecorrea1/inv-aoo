import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/config/config_model.dart';

class ConfigService {
  Future<Config> getAppConfig() async {
    print('consultando la configuración de la app...');
    try {
      final resp = await http.get(Uri.parse('${Enviroments.apiUrl}/config'), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return null;   
      final respBody = jsonDecode(resp.body);
      print(respBody['data']);  
      return configFromJson(resp.body);

    } catch (e) {
      print(e);
      return null;
    }
  }
}
