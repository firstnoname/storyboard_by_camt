import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../blocs/app_manager/app_manager_bloc.dart';
import '../views/views.dart';

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
          locale: DevicePreview.locale(context),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(builder: DevicePreview.appBuilder),
          title: 'Storyboard by CAMT',
          home: buildHome(),
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromRGBO(255, 192, 105, 1),
            accentColor: Colors.cyan[600],
          ),
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
          // Change to splash screen, shouldn't be a LoginView.
          view = LoginView();
        else if (state is AppManagerStateAuthenticated)
          view = ProjectListView();
        else if (state is AppManagerStateUserRegisterFlowStarted)
          view = UserRegisterPolicyAgreement();
        else
          view = LoginView();
        return view;
      },
    );
  }
}
