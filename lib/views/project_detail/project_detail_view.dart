import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../utilities/pdf_manager.dart';
import '../../views/project_detail/bloc/project_detail_bloc.dart';
import '../../widgets/widgets.dart';

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
              title: Text('แก้ไขข้อมูล'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    final pdfFile =
                        await PdfManager.generatePDF(storyboardInfo);
                    PdfManager.openFile(pdfFile);
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
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
                            itemBuilder: (context, index) => Dismissible(
                              key: Key(
                                  storyboardInfo.storyList![index].keyIndex!),
                              onDismissed: (direction) {
                                context
                                    .read<ProjectDetailBloc>()
                                    .add(ProjectDetailRemoveStoryListAt(index));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('ลบข้อมูลเรียบร้อย'),
                                  ),
                                );
                              },
                              child: CardStoryList(
                                  storyboardInfo,
                                  index,
                                  context
                                      .read<ProjectDetailBloc>()
                                      .imagePaths[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(255, 192, 105, 1))),
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
