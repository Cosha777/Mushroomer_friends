import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataService {
  Future<String> getNameFromLocalSource();

  Future<void> setNameToLocalSource(String name);
}

const nameKey = 'NAME_KEY';

class LocalDataSourceSharedPref implements LocalDataService {
  @override
  Future<String> getNameFromLocalSource() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(nameKey);
    return name ?? "Mushroomer";
  }

  @override
  Future<String> setNameToLocalSource(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(nameKey, name);
    return Future.value(name);
  }
}
