
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:loginui/login.dart';

Future<FirebaseUser> facebookLogin() async {
  FirebaseUser currentUser;
  try {
    final FacebookLoginResult facebookLoginResult =
        await fbLogin.logIn(['email']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      final FirebaseUser user =
          (await auth.signInWithCredential(credential)).user;
      currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return currentUser;
    }
  } catch (e) {
    print(e);
  }
  return currentUser;
}

Future<bool> facebookLoginout() async {
  await auth.signOut();
  await fbLogin.logOut();
  return true;
}
