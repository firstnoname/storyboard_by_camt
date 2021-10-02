part of 'project_list_bloc.dart';

@immutable
abstract class ProjectListState {}

class ProjectListInitialState extends ProjectListState {}

class ProjectListInprogress extends ProjectListState {}

class GetStoryboardInfoSuccess extends ProjectListState {}
