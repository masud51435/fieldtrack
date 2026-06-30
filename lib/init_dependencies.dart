import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/// Initialize global dependencies here (e.g., SharedPreferences, Dio, etc.)
Future<void> initDependencies() async {
  await Hive.initFlutter();
}
