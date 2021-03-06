import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/utilities/constants.dart';
import '../views.dart';

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
                      child: _buildVerificationForm(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationForm(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset(defaultCamtVerticalPNG),
            ),
          ),
          SizedBox(height: 36),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email : ',
              suffixIcon: Icon(Icons.email_outlined),
            ),
            onSaved: (value) => BlocProvider.of<LoginBloc>(ctx).email = value,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please enter some text';
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password : ',
              suffixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            onSaved: (value) =>
                BlocProvider.of<LoginBloc>(ctx).password = value,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please enter some text';
            },
          ),
          SizedBox(height: 36),
          GestureDetector(
            child: Container(
              constraints: BoxConstraints.expand(height: 50),
              child: Text("Sign in",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green[200]),
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.all(12),
            ),
            onTap: () async {
              if (!_formGK.currentState!.validate()) {
                return;
              }
              ctx.read<LoginBloc>().add(LoginEmailPasswordSubmitted());
              _formGK.currentState!.save();
            },
          ),

          Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: <Widget>[
                Expanded(child: Divider(color: Colors.green[800])),
                Padding(
                    padding: EdgeInsets.all(6),
                    child: Text("Don???t have an account?",
                        style: TextStyle(color: Colors.black87))),
                Expanded(child: Divider(color: Colors.green[800])),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              constraints: BoxConstraints.expand(height: 50),
              child: Text("Sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.orange[200]),
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(12),
            ),
            onTap: () => Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (context) => UserRegisterView(),
                )),
          ),
          // _buildLoginWithSocialMedia(),
        ],
      );
    });
  }
}
