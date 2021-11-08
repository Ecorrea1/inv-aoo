
class Enviroments {

  static String apiIp       = 'https://inv-api.herokuapp.com';
  static String apiIpSocket =  'https://inv-api.herokuapp.com';
  // static String apiIp       = 'http://192.168.43.148:3000' ;
  // static String apiIpSocket = 'http://192.168.43.148:3000/';

  // static String apiUrl    = Platform.isAndroid ? '$apiIp/api' : 'http://localhost:3000/api';
  // static String socketUrl = Platform.isAndroid ?  apiIpSocket : 'http://localhost:3000/';
  static String apiUrl      = '$apiIp/api';
  static String socketUrl   = apiIpSocket;
}