import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/shared/button_bottom_bar/button_bottom_bar_widget.dart';
import 'package:sizer/sizer.dart';

import 'note_controller.dart';
import 'widgets/color_button_note/color_button_note_widget.dart';
import 'widgets/dropdown_select_note/dropdown_select_note_widget.dart';
import 'widgets/text_form_note/text_form_note_widget.dart';

class NotePage extends StatefulWidget {
  final NoteModel? noteModel;
  final UserModel user;
  const NotePage({
    Key? key,
    this.noteModel,
    required this.user,
  }) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteController noteController = NoteController();
  final AppConfigController configController = AppConfigController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.noteModel != null) {
      noteController.note = widget.noteModel!.copyWith();
      noteController.noteToUpdateNotesPage = widget.noteModel!.copyWith();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConfigController().colorStatus(isWhite: false),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppTheme.colors.background,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 3.w, right: 0, top: 0),
                    padding: EdgeInsets.zero,
                    height: 15.w,
                    width: double.maxFinite,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppTheme.colors.textSimple,
                      tooltip: I18nConst.quit,
                      padding: EdgeInsets.zero,
                      iconSize: 6.w,
                      splashRadius: 6.w,
                      constraints: BoxConstraints(minWidth: 6.w),
                      onPressed: () => noteController.popController(context),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [
                          TextFormNoteWidget(
                            labelText: I18nConst.title,
                            hintText: I18nConst.hintTitle,
                            initialValue: widget.noteModel?.title,
                            onSaved: (title) =>
                                noteController.titleSaved(title),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Observer(builder: (context) {
                                    noteController.lastColorSaved();
                                    return ColorButtonNoteWidget(
                                      key: UniqueKey(),
                                      onPressed: () => noteController
                                          .showDialogNote(context),
                                      colorInit: noteController.lastColor,
                                      colorFinal:
                                          noteController.note.background,
                                      expanded: true,
                                    );
                                  }),
                                  SizedBox(width: 2.w),
                                  Observer(builder: (context) {
                                    return DropdownSelectNoteWidget(
                                      dropdownvalueInitial:
                                          noteController.note.important,
                                      expanded: true,
                                      onChanged: (value) => noteController
                                          .modifyDropdownvalue(value),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          TextFormNoteWidget(
                            expanded: true,
                            isAlwaysShown: true,
                            maxLines: null,
                            minLines: null,
                            initialValue: widget.noteModel?.text,
                            labelText: I18nConst.note,
                            hintText: I18nConst.hintNote,
                            onSaved: (text) => noteController.textSaved(text),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.sp,
                    child: Row(
                      children: [
                        ButtonBottomBarWidget(
                          label: I18nConst.cancel.toUpperCase(),
                          onPressed: () =>
                              noteController.popController(context),
                          expanded: true,
                        ),
                        VerticalDivider(
                            width: borderWidth,
                            thickness: borderWidth,
                            color: AppTheme.colors.border),
                        Observer(builder: (context) {
                          NoteModel note = noteController.note;
                          bool isSave = note.id == "";
                          return ButtonBottomBarWidget(
                            label: isSave
                                ? I18nConst.save.toUpperCase()
                                : I18nConst.edit.toUpperCase(),
                            key: UniqueKey(),
                            onPressed: () => noteController.modifyNote(
                                _formKey, context, widget.user),
                            expanded: true,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
