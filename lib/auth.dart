import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:ems_pro_max/database.dart';
import 'package:ems_pro_max/saved_data.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/services.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('670a7b6a003ca6969294')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development
Storage storage = Storage(client);
Account account = Account(client);
// Register User
Future<String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    saveUserData(name, email, user.$id);
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

// Login User
Future loginUser(String email, String password) async {
  try {
    final user = await account.createEmailPasswordSession(
        email: email, password: password);
    SavedData.saveUserId(user.userId);
    getUserData();

    return true;
  } on AppwriteException catch (e) {
    //print('Error:$e');
    return false;
  }
}

// Logout the user
Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
}

// check if user have an active session or not

Future checkSessions() async {
  try {
    await account.getSession(sessionId: 'current');
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> googleSignIn() async {
  try {
    await account.createOAuth2Session(provider: OAuthProvider.google);
    await Future.delayed(Duration(microseconds: 500));
    return true;
  } on AppwriteException catch (e) {
    if (e.code == 401) {
      print('Authorization failed: ${e.message}');
      return false;
    } else {
      print('AppwriteException: ${e.message}');
      return false;
    }
  } on PlatformException catch (e) {
    if (e.code == 'CANCELED') {
      print('User canceled the login process');
      return false;
    } else {
      print('PlatformException: ${e.message}');
      return false;
    }
  } catch (e) {
    print('Unknown error: $e');
    return false;
  }
}

Future<bool> signWithGoogle() async {
  try {
    final res = await googleSignIn();
    if (res) {
      final user = await account.get();
      if (user != null) {
        print("User logged in: ${user.name}");
        return true;
      }
    }
    print("Google Sign-In failed or user not found.");
    return false;
  } catch (e) {
    print("Error during Google Sign-In: $e");
    return false;
  }
}
