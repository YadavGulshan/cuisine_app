import 'package:flutter/cupertino.dart';

class Info extends ChangeNotifier {
  String _name = "";
  String _email = "";
  int _phone = 0;
  String _address = "";
  String _city = "";
  String _state = "";
  int _zip = 0;
  String _country = "";

  // Info(this._name, this._email, this._phone, this._address, this._city,
  //     this._state, this._zip, this._country);

  //setters
  set setname(String name) {
    _name = name;
    notifyListeners();
  }

  set setemail(String email) {
    _email = email;
    notifyListeners();
  }

  set setphone(int phone) {
    _phone = phone;
    notifyListeners();
  }

  set setaddress(String address) {
    _address = address;
    notifyListeners();
  }

  set setcity(String city) {
    _city = city;
    notifyListeners();
  }

  set setstate(String state) {
    _state = state;
    notifyListeners();
  }

  set setzip(int zip) {
    _zip = zip;
    notifyListeners();
  }

  set setcountry(String country) {
    _country = country;
    notifyListeners();
  }

  // gettgeters
  String get getname => _name;
  String get getemail => _email;
  int get getphone => _phone;
  String get getaddress => _address;
  String get getcity => _city;
  String get getstate => _state;
  int get getzip => _zip;
  String get getcountry => _country;
}
