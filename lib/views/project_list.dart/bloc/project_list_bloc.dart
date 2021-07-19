import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/blocs/base_bloc.dart';
import 'package:storyboard_camt/models/storyboard.dart';
import 'package:storyboard_camt/utilities/database_helper.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends BaseBloc<ProjectListEvent, ProjectListState> {
  BuildContext context;
  ProjectListBloc(this.context, {ProjectListState? initialState})
      : super(context, initialState ?? ProjectListInitialState()) {
    this.add(ProjectListInitial());
  }

  List<StoryboardModel> storyboardsInfo = [];

  @override
  Stream<ProjectListState> mapEventToState(
    ProjectListEvent event,
  ) async* {
    if (event is ProjectListInitial) {
      print('storyboardInfor');
      storyboardsInfo = await DatabaseHelper.instance.getStoryboardInfo();
      yield GetStoryboardInfoSuccess();
    }
  }
}
