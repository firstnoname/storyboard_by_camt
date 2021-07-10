import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc() : super(AppManagerInitial());

  Size? _deviceSize;

  Size? get deviceSize => _deviceSize;

  void setDeviceSize(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
  }

  @override
  Stream<AppManagerState> mapEventToState(
    AppManagerEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AppManagerStarted:
        break;
      case AppManagerLoginSuccessed:
        break;
      case AppManagerLogoutRequested:
        break;
      default:
        yield AppManagerStateUnauthenticated();
        break;
    }
  }
}
