import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/views/project_detail/bloc/project_detail_bloc.dart';
import 'package:storyboard_camt/widgets/widgets.dart';

class ProjectDetailView extends StatelessWidget {
  final StoryboardModel storyboardInfo;
  final void Function() onSubmitted;

  ProjectDetailView(
    this.storyboardInfo,
    this.onSubmitted, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var projectNameController;

    return BlocProvider<ProjectDetailBloc>(
      create: (_) => ProjectDetailBloc(context, storyboardInfo),
      child: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
          storyboardInfo.storyList =
              context.read<ProjectDetailBloc>().storyDetails;
          projectNameController =
              TextEditingController(text: storyboardInfo.projectName);

          return Scaffold(
            appBar: AppBar(
              title: Text('Edit storyboard'),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: projectNameController,
                            onChanged: (value) =>
                                storyboardInfo.projectName = value,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: storyboardInfo.storyList!.length,
                            itemBuilder: (context, index) => CardStoryList(
                                storyboardInfo,
                                index,
                                context.read<ProjectDetailBloc>().imagePaths),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () =>
                  context.read<ProjectDetailBloc>().add(AddedStoryDetail()),
            ),
          );
        },
      ),
    );
  }
}
