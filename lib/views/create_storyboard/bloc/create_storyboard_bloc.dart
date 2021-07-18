import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/blocs/base_bloc.dart';
import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/utilities/database_helper.dart';

part 'create_storyboard_event.dart';
part 'create_storyboard_state.dart';

class CreateStoryboardBloc
    extends BaseBloc<CreateStoryboardEvent, CreateStoryboardState> {
  BuildContext context;

  CreateStoryboardBloc(this.context, {CreateStoryboardState? initialState})
      : super(context, initialState ?? CreateStoryboardInitial()) {
    this.add(StoryboardInitial());
  }

  StoryboardModel? _storyboardInfo = StoryboardModel(storyList: []);
  get storyboardInfo => _storyboardInfo;

  var textProjectNameController = TextEditingController();

  var textDescriptionControllers = <TextEditingController>[];
  var textTimeControllers = <TextEditingController>[];
  var textVdoControllers = <TextEditingController>[];
  var textSoundControllers = <TextEditingController>[];
  var textSoundDurationControllers = <TextEditingController>[];
  var textPlaceControllers = <TextEditingController>[];
  var imagePaths = <File>[];

  var storyDetailList = <StoryDetail>[];

  @override
  Stream<CreateStoryboardState> mapEventToState(
    CreateStoryboardEvent event,
  ) async* {
    switch (event.runtimeType) {
      case StoryboardInitial:
        // if add new storyboard
        _storyboardInfo = StoryboardModel(storyList: []);
        // if edit existing project

        yield CreateStoryboardInitial();
        break;
      case StoryboardFormSubmitted:
        // insert into database.
        _storyboardInfo!.createDate = DateTime.now();
        var isSuccess =
            DatabaseHelper.instance.insertStoryboard(storyboardInfo);

        Navigator.pop(context);
        yield CreateStoryboardSubmitSuccess();
        break;
      case StoryboardItemAdded:
        textTimeControllers.add(TextEditingController());
        textDescriptionControllers.add(TextEditingController());
        textVdoControllers.add(TextEditingController());
        textSoundControllers.add(TextEditingController());
        textSoundDurationControllers.add(TextEditingController());
        textPlaceControllers.add(TextEditingController());
        _storyboardInfo!.storyList!.add(StoryDetail());
        yield CreateStorybaordAddItemSuccess();
        break;
    }
  }
}
