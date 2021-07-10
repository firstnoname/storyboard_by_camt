import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:storyboard_camt/blocs/base_bloc.dart';
import 'package:storyboard_camt/models/models.dart';

part 'create_storyboard_event.dart';
part 'create_storyboard_state.dart';

class CreateStoryboardBloc
    extends BaseBloc<CreateStoryboardEvent, CreateStoryboardState> {
  BuildContext context;

  CreateStoryboardBloc(this.context, {CreateStoryboardState? initialState})
      : super(context, initialState ?? CreateStoryboardInitial()) {
    this.add(StoryboardInitial());
  }

  late StoryboardModel _storyboardInfo;
  get storyboardInfo => _storyboardInfo;

  late List<StoryDetail> _storyDetailList;

  get storyDetailList => _storyDetailList;

  @override
  Stream<CreateStoryboardState> mapEventToState(
    CreateStoryboardEvent event,
  ) async* {
    switch (event.runtimeType) {
      case StoryboardInitial:
        yield CreateStoryboardInitial();
        break;
      case StoryboardFormSubmitted:
        yield CreateStoryboardSubmitSuccess();
        break;
      case StoryboardItemAdded:
        _storyboardInfo.storyList.add(StoryDetail('', '', '', '', '', ''));
        yield CreateStorybaordAddItemSuccess();
        break;
    }
  }
}
