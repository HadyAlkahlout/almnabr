import 'package:flutter/material.dart';
import 'package:teqani/data/responses/main/form/details/transaction_records/transaction_records.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({super.key, required this.record});

  final TransactionRecord record;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.m16,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppMargin.m8,
            children: [
              Text(
                record.updatedAt == null
                    ? ''
                    : record.updatedAt!.substring(0,10),
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              ),
              Text(
                record.updatedAt == null
                    ? ''
                    : record.updatedAt!.substring(11, 16),
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppSize.s1,
                height: AppSize.s8,
                color: ColorManager.primary,
              ),
              Container(
                width: AppSize.s24,
                height: AppSize.s24,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  border: Border.all(
                    color: ColorManager.primary,
                    width: AppSize.s2,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s56),
                ),
              ),
              Expanded(
                child: Container(
                  width: AppSize.s1,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppPadding.p8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    record.writer!.name ?? '',
                    style: getMediumStyle(
                      color: ColorManager.grey,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      record.notes ?? '',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}