import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storyboard_camt/models/models.dart';
import 'package:storyboard_camt/utilities/constants.dart';
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
                title: Text('สร้าง Storyboard'),
                centerTitle: true,
                actions: [
                  Image.asset(
                    defaultCamtVerticalPNG,
                    scale: 20,
                  )
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
                              decoration:
                                  InputDecoration(hintText: 'ชื่อโปรเจค'),
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
                              itemBuilder: (context, index) => Dismissible(
                                key: Key(_items.storyList![index].id!),
                                onDismissed: (direction) {
                                  context.read<CreateStoryboardBloc>().add(
                                      CreateStoryboardRemoveStoryListAt(index));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'view -> ${_items.storyList?.length}'),
                                    ),
                                  );
                                },
                                child: CardStoryList(
                                  context
                                      .read<CreateStoryboardBloc>()
                                      .storyboardInfo,
                                  index,
                                  context
                                      .read<CreateStoryboardBloc>()
                                      .imagePaths[index],
                                ),
                              ),
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
