import 'dart:async';

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
    String _reasonError = '';
    if (event is UserSubmittedForm) {
      await uiFeedback.showLoading();
      try {
        var userCredential = await appManagerBloc.userAuth
            .signUpWithEmail(email!, password!, displayName!)
            .catchError((error) {
          _reasonError = error.toString();
        });

        if (userCredential != null) {
          this.appManagerBloc.userAuth.signInWithEmail(email!, password!);
          await uiFeedback.hideLoading();

          yield UserRegisterSuccess();
          Navigator.pop(context);
        } else {
          await uiFeedback.hideLoading();
          print("Signup failed -> $_reasonError");
          await uiFeedback.showErrorDialog(context,
              title: 'เกิดข้อผิดพลาด', content: _reasonError);

          yield UserRegisterFailed();
        }
      } catch (e) {
        print("Signup failed -> ${e.toString()}");
      }
    }
  }
}
