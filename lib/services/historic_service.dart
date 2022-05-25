import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/historic/historic.model.dart';
import 'package:invapp/models/historic/historic.response.model.dart';
import 'package:rxdart/rxdart.dart';

class HistoricService {
  final _historicController = BehaviorSubject<List<Historic>>();
  Stream<List<Historic>> get historicStream => _historicController.stream;
  Function(List<Historic>) get changeHistoric => _historicController.sink.add;
  List<Historic> get histories => _historicController.value;
  List<Historic> _allhistories = [];

  Future<HistoricResponseModel> getHistorics() async {
    try {
      final response = await http.get(Uri.parse('${Enviroments.apiUrl}/historic'), headers: {'Content-Type': 'application/json'});
      if (response == null) return null;
        final historicResponse = HistoricResponseModel.fromJson(json.decode(response.body));
        if (historicResponse.ok == false)  return historicResponse;
        this._allhistories = historicResponse.data;
        this.changeHistoric(this._allhistories);
    } catch (e) {
      print(e);
      return null;
    }
  }

  void applyFilter(String filter) {
    changeHistoric(this._allhistories.where((histories) => histories.userName.contains(filter.toLowerCase())).toList());
  }

  void cleanFilter() {
    this.changeHistoric(this._allhistories);
  }

  dispose() {
    _historicController?.close();
  }
}
