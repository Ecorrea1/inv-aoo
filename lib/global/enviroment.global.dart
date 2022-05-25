class Enviroments {
  static bool isProduction = true;
  static String apiIp = isProduction ? 'https://inv-api.herokuapp.com' : 'http://192.168.1.15:3000';
  static String apiIpSocket = isProduction ? 'https://inv-api.herokuapp.com' : 'http://192.168.1.15:3000/';
  static String apiUrl = '$apiIp/api';
  static String socketUrl = apiIpSocket;
}
