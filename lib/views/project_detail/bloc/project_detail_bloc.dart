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
  StoryboardModel _storyboardInfo;
  ProjectDetailBloc(this.context, this._storyboardInfo,
      {ProjectDetailState? initialState})
      : super(context, initialState ?? ProjectDetailInitState()) {
    this.add(ProjectDetailInitial());
  }

  List<StoryDetail> storyDetails = [];
  var imagePaths = <File?>[];
  var copyImagePaths = <File?>[];

  @override
  Stream<ProjectDetailState> mapEventToState(
    ProjectDetailEvent event,
  ) async* {
    if (event is ProjectDetailInitial) {
      // get story detial from received id.
      storyDetails =
          await DatabaseHelper.instance.getStoryDetailById(_storyboardInfo.id!);
      if (storyDetails.length != 0) {
        storyDetails.forEach((item) {
          imagePaths.add(File(item.imagePath!));
        });
        copyImagePaths = imagePaths;
      }
      yield GetDetailsSuccess();
    } else if (event is AddedStoryDetail) {
      String storyIndex = _storyboardInfo.storyList == null
          ? '0'
          : (_storyboardInfo.storyList!.length + 1).toString();
      _storyboardInfo.storyList!.add(StoryDetail(keyIndex: storyIndex));
      // _storyboardInfo.storyList!.add(StoryDetail());
      imagePaths.add(null);
      yield AddStoryDetailSuccess();
    } else if (event is ProjectDetailRemoveStoryListAt) {
      // delete story detail in sql.
      var isSuccess = await DatabaseHelper.instance.deleteStoryDetailAt(
          _storyboardInfo.storyList![event.index].id.toString());
      _storyboardInfo.storyList!.removeAt(event.index);
      yield SaveStoryboardSuccess();
    } else if (event is SavedStoryboard) {
      var isSuccess = await DatabaseHelper.instance.updateStoryboard(
        _storyboardInfo,
        imagePaths,
        copyImagePaths,
      );

      if (isSuccess == true) {
        event.onSubmitted();
        Navigator.pop(context);

        yield SaveStoryboardSuccess();
      } else
        yield SaveStoryboardFailed();
    } else {}
  }
}
