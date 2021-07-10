import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/blocs/app_manager/app_manager_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(BuildContext context, State initState)
      : appManagerBloc = BlocProvider.of<AppManagerBloc>(context),
        context = context,
        super(initState);

  final AppManagerBloc appManagerBloc;
  final BuildContext context;
}
