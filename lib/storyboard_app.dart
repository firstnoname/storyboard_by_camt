import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app_manager/app_manager_bloc.dart';
import '../views/views.dart';

import 'landing_view.dart';
import 'main_view.dart';

class StoryboardApp extends StatelessWidget {
  const StoryboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppManagerBloc>(
          create: (_) => AppManagerBloc(),
        ),
      ],
      child: GestureDetector(
        child: MaterialApp(
          title: 'Storyboard by CAMT',
          home: buildHome(),
        ),
      ),
    );
  }

  Widget buildHome() {
    return BlocConsumer<AppManagerBloc, AppManagerState>(
      listenWhen: (previous, current) => previous is AppManagerInitial,
      listener: (context, state) async {
        /// initial context related data here
      },
      builder: (context, state) {
        Widget view;
        if (state is AppManagerInitial)
          view = LoginView();
        // view = LandingView();
        else if (state is AppManagerStateAuthenticated)
          view = MainView();
        else if (state is AppManagerStateUserRegisterFlowStarted)
          view = UserRegisterPolicyAgreement();
        else
          view = LoginView();
        return view;
      },
    );
  }
}