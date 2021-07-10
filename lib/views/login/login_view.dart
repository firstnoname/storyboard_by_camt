import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/main_view.dart';

import 'bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formGK = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: SingleChildScrollView(
                  child: BlocProvider<LoginBloc>(
                    create: (ctx) => LoginBloc(context),
                    child: Form(
                      key: _formGK,
                      child: _buildMainLayout(),
                    ),
                  ),
                ),
              ),
            ),
            // _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainLayout() {
    return LayoutBuilder(builder: (context, constrains) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: Text('Login')),
          SizedBox(height: 36),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email : ',
              suffixIcon: Icon(Icons.email_outlined),
            ),
            // onSaved: (value) =>
            //     BlocProvider.of<LoginBloc>(context).email = value,
            // validator: (value) {
            //   return InputValidator(context).email(value!);
            // },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password : ',
              suffixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            // onSaved: (value) =>
            //     BlocProvider.of<LoginViewBloc>(context).password = value,
            // validator: (value) {
            //   return InputValidator(context).password(value!);
            // },
          ),
          SizedBox(height: 36),
          ElevatedButton(
            child: Text(
              'Login',
              //style: Theme.of(ctx).textTheme.button.copyWith(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainView(),
                  ));
              // if (!_formGK.currentState!.validate()) {
              //   return;
              // }
              // _formGK.currentState!.save();
            },
          ),
          // _buildLoginWithSocialMedia(),
        ],
      );
    });
  }
}
