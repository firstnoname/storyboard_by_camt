import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/views/create_storyboard/bloc/create_storyboard_bloc.dart';
import 'package:storyboard_camt/widgets/widgets.dart';

class CreateStoryboardView extends StatefulWidget {
  final void Function() onSubmitted;
  CreateStoryboardView(this.onSubmitted, {Key? key}) : super(key: key);

  @override
  _CreateStoryboardViewState createState() => _CreateStoryboardViewState();
}

class _CreateStoryboardViewState extends State<CreateStoryboardView> {
  int counter = 1;
  final _formGK = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      top: false,
      bottom: false,
      child: BlocProvider<CreateStoryboardBloc>(
        create: (_) => CreateStoryboardBloc(context),
        child: BlocBuilder<CreateStoryboardBloc, CreateStoryboardState>(
          builder: (context, state) {
            StoryboardModel _items =
                context.read<CreateStoryboardBloc>().storyboardInfo;
            return Scaffold(
              appBar: AppBar(
                title: Text('Create storyboard'),
                centerTitle: true,
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
                              onChanged: (value) => _items.projectName = value,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter some text';
                              },
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _items.storyList!.length,
                              itemBuilder: (context, index) => CardStoryList(
                                  context
                                      .read<CreateStoryboardBloc>()
                                      .storyboardInfo,
                                  index,
                                  context
                                      .read<CreateStoryboardBloc>()
                                      .imagePaths[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  context
                              .read<CreateStoryboardBloc>()
                              .textTimeControllers
                              .length >
                          0
                      ? Visibility(
                          visible: !keyboardIsOpen,
                          child: Positioned(
                            bottom: 24,
                            child: RaisedButton(
                              child: Text('Save'),
                              onPressed: () {
                                if (!_formGK.currentState!.validate()) {
                                  return;
                                }
                                context.read<CreateStoryboardBloc>().add(
                                    StoryboardFormSubmitted(
                                        widget.onSubmitted));
                                _formGK.currentState!.save();
                              },
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              floatingActionButton: Visibility(
                visible: !keyboardIsOpen,
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => context
                      .read<CreateStoryboardBloc>()
                      .add(StoryboardItemAdded()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
