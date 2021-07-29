import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/blocs/base_bloc.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends BaseBloc<UserRegisterEvent, UserRegisterState> {
  String? email;
  String? displayName;
  String? password;

  UserRegisterBloc(BuildContext context)
      : super(context, UserRegisterInitial());

  @override
  Stream<UserRegisterState> mapEventToState(
    UserRegisterEvent event,
  ) async* {
    if (event is UserSubmittedForm) {
      try {
        var userCredential = await appManagerBloc.userAuth
            .signUpWithEmail(email!, password!, displayName!);

        if (userCredential.isNotEmpty) {
          this.appManagerBloc.userAuth.signInWithEmail(email!, password!);
          yield UserRegisterSuccess();
        }
      } catch (e) {
        print("Signup failed -> ${e.toString()}");
        yield UserRegisterFailed();
      }
    }
  }
}
