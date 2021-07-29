import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/a_bloc_observer.dart';
import '../storyboard_app.dart';

Future<void> main() async {
  Bloc.observer = ABlocObserver();
  runApp(StoryboardApp());
  // services.SystemChrome.setPreferredOrientations(
  //     [services.DeviceOrientation.portraitUp]).then((_) {
  //   runApp(StoryboardApp());
  // });
}
