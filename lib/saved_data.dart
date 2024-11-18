import 'package:shared_preferences/shared_preferences.dart';

class SavedData {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Save user id on device

  static Future<void> saveUserId(String id) async {
    await preferences!.setString("UserID", id);
  }

  // Get the user Id

  static String getUserId() {
    return preferences!.getString("UserID") ?? "";
  }

// Save user name
  static Future<void> saveUserName(String name) async {
    await preferences!.setString("name", name);
  }
  // Get the user Id

  static String getUserName() {
     //final name =preferences!.getString("name") ?? "";
    print( 'Name:${preferences!.getString("name")}' );
    //return name;
    return preferences!.getString("name") ?? "";
  }

// Save user email
  static Future<void> saveUserEmail(String email) async {
    await preferences!.setString("email", email);
  }
  // Get the user email

  static String getUserEmail() {
   
    return preferences!.getString("email") ?? "";
    
    
  }

}