import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc() : super(ProjectListInitial());

  @override
  Stream<ProjectListState> mapEventToState(
    ProjectListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
