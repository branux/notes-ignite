import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:notes_ignite/domain/note/model/note_model.dart';

import '/modules/notes/widgets/card_note/card_note_widget.dart';

class SlidableCardWidget extends StatelessWidget {
  final void Function(BuildContext) onDeleted;
  final void Function(BuildContext) onEdit;
  final void Function(BuildContext) onShared;
  final Future<bool> Function()? confirmDismiss;
  final VoidCallback onDismissed;
  final NoteModel note;
  const SlidableCardWidget({
    Key? key,
    required this.onDeleted,
    required this.onEdit,
    required this.onShared,
    this.confirmDismiss,
    required this.onDismissed,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: onDismissed,
          confirmDismiss: confirmDismiss,
        ),
        children: [
          SlidableAction(
            onPressed: (context) => onDeleted(context),
            autoClose: true,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 6,
            onPressed: (context) => onShared(context),
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.share_rounded,
            label: 'Compartilhar',
          ),
          SlidableAction(
            flex: 4,
            onPressed: (context) => onEdit(context),
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outline,
            label: 'Editar',
          ),
        ],
      ),
      child: CardNoteWidget(key: UniqueKey(), note: note),
    );
  }
}
