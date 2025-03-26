import 'package:latlong2/latlong.dart';

abstract class AppConstants {
  static const Duration INTERNET_OBSERVING_INTERVAL = Duration(seconds: 7);
  static const String INTERNET_OBSERVING_URL = 'https://www.google.com/';
  static const double MIN_ORDER_PRICE = 19.99;
  static const String PASSWORD_REG_EXP =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~`)%\-(_+=;:,.<>/?"[{\]}\\|^]).{8,}$';
  static const String EMAIL_REG_EXP = r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const LatLng MAP_INITIAL_CENTER = LatLng(53.9, 27.5667);
  static const String WORKING_HOURS = '10:00 - 21:00';
}
