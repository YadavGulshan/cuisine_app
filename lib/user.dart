// User data will be stored here

import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String userName = "";
  String userEmail = "";
  double userPhone = 0.0;
  String userImage = "";
  String userAddress = "";
  String userCity = "";
  String userState = "";
  String userZipcode = "";
  String userCountry = "";
  double userLatitude = 0.0;
  double userLongitude = 0.0;

  get getUserName => userName;
  get getUserEmail => userEmail;
  get getUserPhone => userPhone;
  get getUserImage => userImage;
  get getUserAddress => userAddress;
  get getUserCity => userCity;
  get getUserState => userState;
  get getUserZipcode => userZipcode;
  get getUserCountry => userCountry;
  get getUserLatitude => userLatitude;
  get getUserLongitude => userLongitude;
}
