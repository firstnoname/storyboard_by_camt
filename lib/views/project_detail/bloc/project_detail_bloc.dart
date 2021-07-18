import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/blocs/base_bloc.dart';
import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/utilities/database_helper.dart';

part 'project_detail_event.dart';
part 'project_detail_state.dart';

class ProjectDetailBloc
    extends BaseBloc<ProjectDetailEvent, ProjectDetailState> {
  BuildContext context;
  String id;
  ProjectDetailBloc(this.context, this.id, {ProjectDetailState? initialState})
      : super(context, initialState ?? ProjectDetailInitState()) {
    this.add(ProjectDetailInitial());
  }

  List<StoryDetail> storyDetails = [];
  List<File> imagePaths = [];

  @override
  Stream<ProjectDetailState> mapEventToState(
    ProjectDetailEvent event,
  ) async* {
    if (event is ProjectDetailInitial) {
      // get story detial from received id.
      storyDetails = await DatabaseHelper.instance.getStoryDetailById(id);
      yield GetDetailsSuccess();
    } else {}
  }
}
