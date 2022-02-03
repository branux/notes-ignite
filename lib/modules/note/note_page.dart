import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/shared/button_bottom_bar/button_bottom_bar_widget.dart';

import 'note_controller.dart';
import 'widgets/color_button_note/color_button_note_widget.dart';
import 'widgets/dropdown_select_note/dropdown_select_note_widget.dart';
import 'widgets/text_form_note/text_form_note_widget.dart';

class NotePage extends StatefulWidget {
  final NoteModel? noteModel;
  const NotePage({Key? key, this.noteModel}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteController noteController = NoteController();
  final AppConfigController configController = AppConfigController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.noteModel != null) noteController.note = widget.noteModel!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlay = configController.colorStatus(isWhite: false);
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: AppTheme.colors.textSimple,
          onPressed: () => noteController.popController(context),
        ),
        toolbarHeight: 70,
        systemOverlayStyle: overlay,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    TextFormNoteWidget(
                      labelText: "Titulo",
                      hintText: "Digite aqui o titulo",
                      initialValue: widget.noteModel?.title,
                      onSaved: (title) => noteController.titleSaved(title),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Row(
                        children: [
                          Observer(builder: (context) {
                            return ColorButtonNoteWidget(
                              onPressed: () =>
                                  noteController.showDialogNote(context),
                              color: noteController.note.background,
                              expanded: true,
                            );
                          }),
                          const SizedBox(width: 18),
                          Observer(builder: (context) {
                            return DropdownSelectNoteWidget(
                              dropdownvalueInitial:
                                  noteController.note.important,
                              expanded: true,
                              onChanged: (value) =>
                                  noteController.modifyDropdownvalue(value),
                            );
                          }),
                        ],
                      ),
                    ),
                    TextFormNoteWidget(
                      expanded: true,
                      isAlwaysShown: true,
                      maxLines: null,
                      minLines: null,
                      initialValue: widget.noteModel?.text,
                      labelText: "Nota",
                      hintText: "Digite aqui a nota",
                      onSaved: (text) => noteController.textSaved(text),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Observer(builder: (context) {
                    return ButtonBottomBarWidget(
                      label: "CANCELAR",
                      onPressed: () => noteController.popController(context),
                      expanded: true,
                    );
                  }),
                  VerticalDivider(
                      width: 1, thickness: 1, color: AppTheme.colors.border),
                  Observer(builder: (context) {
                    NoteModel note = noteController.note;
                    bool isSave = note.id == "";
                    return ButtonBottomBarWidget(
                      label: isSave ? "SALVAR" : "EDITAR",
                      key: UniqueKey(),
                      onPressed: () =>
                          noteController.createNote(_formKey, context),
                      expanded: true,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
