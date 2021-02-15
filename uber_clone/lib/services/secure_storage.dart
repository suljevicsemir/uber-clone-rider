import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/country_call_number.dart';
class CallNumbersProvider {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();




  Future<void> writeKey() async {
    await _flutterSecureStorage.write(key: 'callNumbersAPI', value: '4f22ac9c2a2184b874554b8261f80dde');
  }





  Future<List<CountryCallNumber>> getCountries() async {
    String apiKey = await _flutterSecureStorage.read(key: 'callNumbersAPI');
    String url = "http://apilayer.net/api/countries?access_key=$apiKey";

    var countries = await http.get(url);

    print(countries);


  }






}