import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:sizer/sizer.dart';
import 'notes_controller.dart';
import 'notes_state.dart';
import 'widgets/notes_app_bar/notes_app_bar_widget.dart';
import 'widgets/slidable_card/slidable_card_widget.dart';

class NotesPage extends StatefulWidget {
  final UserModel userModel;
  const NotesPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final AppConfigController configController = AppConfigController();
  final NotesController notesController = NotesController();

  @override
  void initState() {
    notesController.showListNotes(user: widget.userModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = Orientation.portrait == orientation ? (100.w) : (105.h);
    double height = Orientation.portrait == orientation ? (100.h) : (105.w);
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: NotesAppBarWidget(
        user: widget.userModel,
        onTap: () {},
        menuSelect: (value) =>
            notesController.selectListMenu(context, value, widget.userModel),
        menuList: notesController.getListMenu(),
        width: width,
        height: height,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  image: ExactAssetImage(AppTheme.images.note),
                  fit: BoxFit.contain,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
          ),
          Observer(builder: (_) {
            Widget body = Container();
            if (notesController.state is NotesStateLoading) {
              body = Column(
                  children: const [Center(child: CircularProgressIndicator())]);
            } else if (notesController.state is NotesStateSuccess) {
              body = AnimatedList(
                padding: const EdgeInsets.only(top: 10),
                key: _listKey,
                initialItemCount: notesController.notes.length,
                itemBuilder: (context, index, animation) {
                  return Column(
                    children: [
                      SlidableCardWidget(
                        key: Key(notesController.notes[index].toString()),
                        onDeleted: (context) =>
                            notesController.onDeleted(index, _listKey, context),
                        onDismissed: () => notesController.onDismissed(
                            index, context, _listKey),
                        confirmDismiss: () =>
                            notesController.confirmDismiss(index, context),
                        note: notesController.notes[index],
                        onEdit: (context) async {
                          await notesController.onEdit(
                              context: context,
                              note: notesController.notes[index],
                              index: index,
                              user: widget.userModel);
                        },
                        onShared: (context) => notesController.onShared(
                          context: context,
                          note: notesController.notes[index],
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  );
                },
              );
            }
            return body;
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: AppTheme.colors.textGradient),
        backgroundColor: AppTheme.colors.backgroundColor,
        tooltip: I18nConst.addIcon,
        onPressed: () async {
          await notesController.onCreated(
              context: context, key: _listKey, user: widget.userModel);
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_listKey.currentState != null) _listKey.currentState!.dispose();
    notesController.dispose();
    super.dispose();
  }
}
