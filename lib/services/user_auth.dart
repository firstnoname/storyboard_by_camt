import 'package:firebase_auth/firebase_auth.dart';
import 'package:storyboard_camt/blocs/app_manager/app_manager_bloc.dart';

class UserAuth {
  final AppManagerBloc _appManagerBloc;
  static UserAuth? _cache;
  final FirebaseAuth _firebaseAuth;

  User? get firebaseCurrentUser => _firebaseAuth.currentUser;

  factory UserAuth(AppManagerBloc appManagerBloc) {
    if (_cache == null) _cache = UserAuth._(appManagerBloc);
    return _cache!;
  }

  UserAuth._(this._appManagerBloc) : _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<UserCredential> signInWithEmail(String email, String pass) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
    await checkCurrentUserProfile();
    return userCredential;
  }

  Future signUpWithEmail(String email, String pass, String displayName) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      User user = result.user!;
      user.updateDisplayName(displayName);

      return user;
    } on FirebaseAuthException catch (e) {
      print('Signup failed -> ${e.message}');
    }
  }

  Future<void> signOut() => _firebaseAuth
      .signOut()
      .then((value) => print('Log out success'))
      .catchError((e) => print('Error occurred: ${e.toString()}'));

  checkCurrentUserProfile() async {
    var user = _firebaseAuth.currentUser;
    if (user == null) {
      _appManagerBloc.registerState = true;
      _appManagerBloc.updateCurrentUserProfile(user);
    }

    _appManagerBloc.add(AppManagerLoginSuccessed());
  }
}
