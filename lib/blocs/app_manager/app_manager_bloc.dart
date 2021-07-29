import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
// import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/services/user_auth.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  late UserAuth _userAuth;

  UserAuth get userAuth => _userAuth;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool registerState = false;

  Size? _deviceSize;

  Size? get deviceSize => _deviceSize;

  void setDeviceSize(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
  }

  AppManagerBloc({AppManagerState? state, BuildContext? context})
      : super(state ?? AppManagerInitial()) {
    Firebase.initializeApp().then((value) async {
      _userAuth = UserAuth(this);
      this.add(AppManagerStarted());
    }).catchError((e) {
      print('Initial firebase failed : ${e.toString()}');
    });
  }

  @override
  Stream<AppManagerState> mapEventToState(
    AppManagerEvent event,
  ) async* {
    if (event is AppManagerStarted) {
      if (_userAuth.isLoggedIn()) {
        try {
          await _userAuth.checkCurrentUserProfile();
        } catch (e) {
          print(e.toString());
          yield await _logoutProcess();
        }
      } else {
        print('No persistent user data');
        yield AppManagerStateUnauthenticated();
      }
    } else if (event is AppManagerLoginSuccessed) {
      yield AppManagerStateAuthenticated();
    } else if (event is AppManagerLogoutRequested) {
    } else if (event is AppManagerStateUnauthenticated) {}
  }

  Future<AppManagerState> _logoutProcess() async {
    await _userAuth.signOut();
    _currentUser = null;
    return AppManagerStateUnauthenticated();
  }

  void updateCurrentUserProfile(User? user) {
    _currentUser = user;
  }
}
