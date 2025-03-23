import 'package:flutter/cupertino.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {}

abstract class BaseViewModelInputs{
 void start(BuildContext context);
 void dispose();
}

abstract mixin class BaseViewModelOutputs{}