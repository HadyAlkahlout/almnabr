import 'package:flutter/material.dart';
import 'package:teqani/data/responses/main/form/details/transaction_notes/transaction_notes.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/Item_note.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';

class Notes extends StatelessWidget {
  const Notes({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return notes.isNotEmpty
        ? ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => ItemNote(
        note: notes[index],
      ),
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: AppSize.s1,
        color: ColorManager.lightGrey,
      ),
      itemCount: notes.length,
    )
        : ViewNoData();
  }
}
