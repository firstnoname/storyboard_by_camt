part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailEvent {}

class ProjectDetailInitial extends ProjectDetailEvent {}

class AddedStoryDetail extends ProjectDetailEvent {}

class SavedStoryboard extends ProjectDetailEvent {
  final void Function() onSubmitted;

  SavedStoryboard(this.onSubmitted);
}

class ProjectDetailRemoveStoryListAt extends ProjectDetailEvent {
  final index;

  ProjectDetailRemoveStoryListAt(this.index);
}
