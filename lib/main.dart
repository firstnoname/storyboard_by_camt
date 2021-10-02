import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/a_bloc_observer.dart';
import '../storyboard_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = ABlocObserver();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => StoryboardApp(),
    ),
  );
  // services.SystemChrome.setPreferredOrientations(
  //     [services.DeviceOrientation.portraitUp]).then((_) {
  //   runApp(StoryboardApp());
  // });
}
