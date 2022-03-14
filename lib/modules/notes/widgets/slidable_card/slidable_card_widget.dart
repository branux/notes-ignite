import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '/modules/notes/widgets/card_note/card_note_widget.dart';
import 'slidable_custom_action_widget.dart';

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
          SlidableCustomActionWidget(
            onPressed: (context) => onDeleted(context),
            autoClose: true,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: I18nConst.delete,
            sizeIcon: 4.h,
            style: AppTheme.textStyles.textSlidableButton,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableCustomActionWidget(
            flex: 6,
            onPressed: (context) => onShared(context),
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.share_rounded,
            label: I18nConst.shared,
            sizeIcon: 4.h,
            style: AppTheme.textStyles.textSlidableButton,
          ),
          SlidableCustomActionWidget(
            flex: 4,
            onPressed: (context) => onEdit(context),
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outline,
            label: I18nConst.edit,
            sizeIcon: 4.h,
            style: AppTheme.textStyles.textSlidableButton,
          ),
        ],
      ),
      child: CardNoteWidget(key: UniqueKey(), note: note),
    );
  }
}
