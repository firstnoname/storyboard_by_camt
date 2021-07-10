import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../blocs/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(BuildContext context) : super(context, LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoginEmailPasswordSubmitted:
        yield LoginEmailPasswordSubmitSuccess();
        break;
    }
  }
}
