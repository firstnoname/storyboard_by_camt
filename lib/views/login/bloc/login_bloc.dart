import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/views/project_list.dart/project_list_view.dart';
import '../../../blocs/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  String? email;
  String? password;

  LoginBloc(BuildContext context) : super(context, LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    await uiFeedback.showLoading();
    switch (event.runtimeType) {
      case LoginEmailPasswordSubmitted:
        try {
          var userCredential =
              await appManagerBloc.userAuth.signInWithEmail(email!, password!);
          print('login status -> ${userCredential.user!.email}');
          if (userCredential.user != null) {
            // check current user.
            var user = appManagerBloc.userAuth.firebaseCurrentUser;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectListView(),
              ),
            );
            yield LoginEmailPasswordSubmitSuccess();
          } else
            yield LoginFailed();
        } catch (e) {
          print('login failed -> ${e.toString()}');
          yield LoginFailed();
        } finally {
          await uiFeedback.hideLoading();
        }
        break;
    }
  }
}
