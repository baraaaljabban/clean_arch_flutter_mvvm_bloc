import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/storage_keys.dart';
import '../models/user_model.dart';

class LoginLocalDataSource {
  final SharedPreferences prefs;

  const LoginLocalDataSource({required this.prefs});

  Future<void> persistLoggedInUser(User user) async {
    await prefs.setBool(StorageKeys.isLoggedIn, true);
    // Optionally persist minimal user snapshot
    await prefs.setString('${StorageKeys.appPrefix}username', user.username);
    await prefs.setString('${StorageKeys.appPrefix}email', user.email);
  }
}
