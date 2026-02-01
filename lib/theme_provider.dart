import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDarkMode = false;
  bool getThemeValue() => _isDarkMode;

  ThemeProvider() {
    loadTheme(); // load saved theme on init
  }


  void updateTheme({required bool value}) async{
    _isDarkMode = value;
    notifyListeners();

    // Save to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
}


  void loadTheme() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // default light
    notifyListeners();
  }

}

