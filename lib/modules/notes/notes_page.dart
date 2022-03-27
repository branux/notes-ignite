import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late GlobalKey<AnimatedListState> _listKey;
  late AppConfigController configController;
  late NotesController notesController;

  @override
  void initState() {
    _listKey = GlobalKey<AnimatedListState>();
    configController = AppConfigController();
    notesController = NotesController();
    notesController.autoRun(context);
    notesController.showListNotes(
        user: widget.userModel,
        addNotes: (notes) => notesController.addNotes(notes, _listKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConfigController().colorStatus(isWhite: false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.colors.background,
        appBar: NotesAppBarWidget(
          user: widget.userModel,
          onTap: () {},
          menuSelect: (value) =>
              notesController.selectListMenu(context, value, widget.userModel),
          menuList: notesController.getListMenu(),
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
            Observer(builder: (context) {
              return AnimatedList(
                padding: const EdgeInsets.only(top: 10),
                key: _listKey,
                initialItemCount: notesController.notes.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index, animation) {
                  return Column(
                    children: [
                      SlidableCardWidget(
                        key: Key(notesController.notes[index].toString()),
                        onDeleted: (context) => notesController.onDeleted(
                            notesController.notes[index].id,
                            () => notesController.onAnimationDeletion(
                                index, _listKey, context)),
                        onDismissed: () => notesController.onDismissed(
                            index, context, _listKey),
                        confirmDismiss: () => notesController.confirmDismiss(
                          notesController.notes[index].id,
                        ),
                        note: notesController.notes[index],
                        onEdit: (context) => notesController.onEdit(
                            context: context,
                            note: notesController.notes[index],
                            index: index,
                            user: widget.userModel),
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
            }),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 7.h,
          width: 7.h,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.add, color: AppTheme.colors.textGradient),
              backgroundColor: AppTheme.colors.backgroundColor,
              tooltip: I18nConst.addIcon,
              onPressed: () async {
                await notesController.onCreated(
                    context: context, key: _listKey, user: widget.userModel);
              },
            ),
          ),
        ),
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
