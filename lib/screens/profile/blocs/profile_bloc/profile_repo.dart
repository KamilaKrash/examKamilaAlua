import 'dart:convert';

import 'package:application/screens/profile/models/user.dart';
import 'package:application/services/storage/storage.dart';


class ProfileRepo {
  ProfileRepo();

  Future<User?> getUser() async {
    try {
      String? userJson = await StorageService.getString(key: 'user');
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        return User.fromJson(userMap);
      } else {
        return null;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> updateUser({
    required User user
  }) async {
    try {
      String userJson = jsonEncode(user.toJson());
      return await StorageService.setString(key:'user',value: userJson);
    } catch (e) {
      throw e.toString();
    }
  }
}
