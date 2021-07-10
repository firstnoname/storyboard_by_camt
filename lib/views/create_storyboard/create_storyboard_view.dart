import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/blocs/app_manager/app_manager_bloc.dart';
import 'package:storyboard_camt/views/create_storyboard/bloc/create_storyboard_bloc.dart';

class CreateStoryboardView extends StatefulWidget {
  CreateStoryboardView({Key? key}) : super(key: key);

  @override
  _CreateStoryboardViewState createState() => _CreateStoryboardViewState();
}

class _CreateStoryboardViewState extends State<CreateStoryboardView> {
  final _formKey = GlobalKey<FormState>();
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      top: false,
      bottom: false,
      child: BlocProvider<CreateStoryboardBloc>(
        create: (_) => CreateStoryboardBloc(context),
        child: BlocBuilder<CreateStoryboardBloc, CreateStoryboardState>(
          // buildWhen: (previous, current) {

          // },
          builder: (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
