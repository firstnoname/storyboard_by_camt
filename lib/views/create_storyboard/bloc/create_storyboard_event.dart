part of 'create_storyboard_bloc.dart';

@immutable
abstract class CreateStoryboardEvent {}

class StoryboardInitial extends CreateStoryboardEvent {}

class StoryboardFormSubmitted extends CreateStoryboardEvent {}

class StoryboardItemAdded extends CreateStoryboardEvent {}
