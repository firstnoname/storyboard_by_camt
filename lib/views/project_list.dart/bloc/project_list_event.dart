part of 'project_list_bloc.dart';

@immutable
abstract class ProjectListEvent {}

class ProjectListInitial extends ProjectListEvent {}

class UserPressedSignOut extends ProjectListEvent {}

class ProjectListRemoveSingleProject extends ProjectListEvent {
  final StoryboardModel project;

  ProjectListRemoveSingleProject(this.project);
}
