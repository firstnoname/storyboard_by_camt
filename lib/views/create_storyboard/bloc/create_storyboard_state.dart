part of 'create_storyboard_bloc.dart';

@immutable
abstract class CreateStoryboardState {}

class CreateStoryboardInitial extends CreateStoryboardState {}

class CreateStoryboardSubmitSuccess extends CreateStoryboardState {}

class CreateStorybaordAddItemSuccess extends CreateStoryboardState {}

class CreateStoryboardFailure extends CreateStoryboardState {}
