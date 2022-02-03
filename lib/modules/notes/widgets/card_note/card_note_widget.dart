import 'package:flutter/material.dart';
import '/core/core.dart';
import '/domain/note/model/note_model.dart';

class CardNoteWidget extends StatelessWidget {
  final NoteModel note;
  const CardNoteWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: note.background,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: AppTheme.textStyles.textTitle,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 13),
          Text(
            note.text,
            style: AppTheme.textStyles.textSubtitle,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  note.dataString(),
                  style: AppTheme.textStyles.textSubtitle,
                  textAlign: TextAlign.justify,
                )),
                Flexible(
                  child: Text(
                    note.important,
                    style: AppTheme.textStyles.textSubtitleOpacity,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(height: 1, color: AppTheme.colors.divider, thickness: 1),
        ],
      ),
    );
  }
}
