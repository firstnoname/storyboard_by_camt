import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/utilities/pdf_manager.dart';
import 'package:storyboard_camt/views/pdf_creator/pdf_creator_view.dart';
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
    final _formGK = GlobalKey<FormState>();

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
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      // TODO function create pdf view.
                      final pdfFile = await PdfManager.generatePDF();
                      PdfManager.openFile(pdfFile);
                    },
                    child: Icon(Icons.share))
              ],
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formGK,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: projectNameController,
                            onChanged: (value) =>
                                storyboardInfo.projectName = value,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Please enter some text';
                            },
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
                    onPressed: () {
                      if (!_formGK.currentState!.validate()) {
                        return;
                      }
                      context
                          .read<ProjectDetailBloc>()
                          .add(SavedStoryboard(onSubmitted));
                      _formGK.currentState!.save();
                    },
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
