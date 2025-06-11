import 'package:shared_preferences/shared_preferences.dart';
import 'profile_local_data_source.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences prefs;

  ProfileLocalDataSourceImpl({required this.prefs});

  @override
  Future<int?> getUserId() async {
    return prefs.getInt('userId');
  }
}
