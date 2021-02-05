class CountryCallNumber {
  final String countryName, countryCode;
  final int callNumber;

  CountryCallNumber({this.countryName, this.countryCode, this.callNumber});


  CountryCallNumber.fromJson(Map<String, dynamic> json) :
      countryName = json['country_name'],
      callNumber = json['dialling_code'],
      countryCode = 'proba';





}