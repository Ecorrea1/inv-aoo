class Enviroments {

  static bool isProduction = true;
  static String apiIp = isProduction ? 'https://inv-api.herokuapp.com' : 'http://192.168.1.14:3000';
  static String apiIpSocket = isProduction ? 'https://inv-api.herokuapp.com' : 'http://192.168.1.14:3000/';
  // static String apiUrl    = Platform.isAndroid ? '$apiIp/api' : 'http://localhost:3000/api';
  // static String socketUrl = Platform.isAndroid ?  apiIpSocket : 'http://localhost:3000/';
  static String apiUrl = '$apiIp/api';
  static String socketUrl = apiIpSocket;
}
