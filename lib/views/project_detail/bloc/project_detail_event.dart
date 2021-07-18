part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailEvent {}

class ProjectDetailInitial extends ProjectDetailEvent {}

class AddedStoryDetail extends ProjectDetailEvent {}

class SavedStoryboard extends ProjectDetailEvent {}
