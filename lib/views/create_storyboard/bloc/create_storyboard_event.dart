part of 'create_storyboard_bloc.dart';

@immutable
abstract class CreateStoryboardEvent {}

class StoryboardInitial extends CreateStoryboardEvent {}

class StoryboardFormSubmitted extends CreateStoryboardEvent {
  final void Function() onSubmitted;

  StoryboardFormSubmitted(this.onSubmitted);
}

class StoryboardItemAdded extends CreateStoryboardEvent {}
