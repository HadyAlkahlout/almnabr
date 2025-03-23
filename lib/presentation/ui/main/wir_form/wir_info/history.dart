import 'package:flutter/material.dart';
import 'package:teqani/data/responses/main/form/details/transaction_records/transaction_records.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/Item_history.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';

class History extends StatelessWidget {
  const History({super.key, required this.history});

  final List<TransactionRecord> history;

  @override
  Widget build(BuildContext context) {
    return history.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => ItemHistory(
              record: history[index],
            ),
            separatorBuilder: (BuildContext context, int index) => Container(
              width: double.infinity,
              height: AppSize.s1,
              color: ColorManager.lightGrey,
            ),
            itemCount: history.length,
          )
        : ViewNoData();
  }
}
