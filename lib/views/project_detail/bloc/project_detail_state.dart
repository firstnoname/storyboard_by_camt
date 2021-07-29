part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailState {}

class ProjectDetailInitState extends ProjectDetailState {}

class GetDetailsSuccess extends ProjectDetailState {}

class AddStoryDetailSuccess extends ProjectDetailState {}

class SaveStoryboardSuccess extends ProjectDetailState {}

class SaveStoryboardFailed extends ProjectDetailState {}
