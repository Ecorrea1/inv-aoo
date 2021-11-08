import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/config/config_model.dart';

class ConfigService {
  Future<Config> getAppConfig() async {
    print('consultando la configuración de la app...');
    try {
      final resp = await http.get(Uri.parse('${Enviroments.apiUrl}/config'),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        final decodedResp = json.decode(resp.body);
        final configModel = Config.fromJson(decodedResp['data']);
        return configModel;
      }
      print('Estoy aca');
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
