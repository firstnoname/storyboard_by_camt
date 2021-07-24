import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:storyboard_camt/utilities/database_helper.dart';
import 'package:storyboard_camt/views/project_detail/project_detail_view.dart';
import 'package:storyboard_camt/views/project_list.dart/bloc/project_list_bloc.dart';
import '../../views/create_storyboard/create_storyboard_view.dart';

class ProjectListView extends StatefulWidget {
  const ProjectListView({Key? key}) : super(key: key);

  @override
  _ProjectListViewState createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  String? _colorName;
  Color? _color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectListBloc>(
      create: (context) => ProjectListBloc(context),
      child: BlocBuilder<ProjectListBloc, ProjectListState>(
        builder: (context, state) {
          var storyboardsInfo = context.read<ProjectListBloc>().storyboardsInfo;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.cyan[200],
                title: Text('Storyboard by CAMT'),
              ),
              body: SafeArea(
                child: CircularMenu(
                  alignment: Alignment.bottomCenter,
                  startingAngleInRadian: 1.25 * 3.14,
                  endingAngleInRadian: 1.75 * 3.14,
                  backgroundWidget: ListView.builder(
                    itemCount: storyboardsInfo.length,
                    itemBuilder: (context, index) => Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProjectDetailView(storyboardsInfo[index], () {
                                context
                                    .read<ProjectListBloc>()
                                    .add(ProjectListInitial());
                              }),
                            )),
                        child: ListTile(
                          title: Text(
                            '${storyboardsInfo[index].projectName}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Icon(Icons.ac_unit),
                          trailing: Text(
                              '${DateFormat('dd-MM-yyyy').format(storyboardsInfo[index].createDate!)}'),
                        ),
                      ),
                    ),
                  ),
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceInOut,
                  toggleButtonColor: Colors.cyan[400],
                  items: [
                    CircularMenuItem(
                        icon: Icons.home,
                        color: Colors.brown,
                        onTap: () {
                          setState(() {
                            _color = Colors.brown;
                            _colorName = 'Brown';
                          });
                        }),
                    CircularMenuItem(
                        icon: Icons.add,
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateStoryboardView(() {
                                      context
                                          .read<ProjectListBloc>()
                                          .add(ProjectListInitial());
                                    })),
                          );
                          setState(() {
                            _color = Colors.green;
                            _colorName = 'Green';
                          });
                        }),
                    CircularMenuItem(
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {
                          DatabaseHelper.instance
                              .deleteStoryboard(storyboardsInfo);

                          setState(() {
                            _color = Colors.red;
                            _colorName = 'red';
                          });
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
