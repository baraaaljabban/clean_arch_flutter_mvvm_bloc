import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/storage_keys.dart';
import '../../../../core/dependency_registrar/dependencies.dart';

class QuestionLocalDataSource {
  final SharedPreferences prefs = sl();

  // const QuestionLocalDataSource({required this.prefs});

  Future<void> saveLastRefresh(DateTime time) async {
    await prefs.setString(StorageKeys.lastQuestionsRefresh, time.toIso8601String());
  }

  DateTime? getLastRefresh() {
    final String? iso = prefs.getString(StorageKeys.lastQuestionsRefresh);
    if (iso == null || iso.isEmpty) return null;
    return DateTime.tryParse(iso);
  }
}
