import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

VoidCallback showLoading() {
  FocusManager.instance.primaryFocus?.unfocus();
  return BotToast.showLoading(backButtonBehavior: BackButtonBehavior.ignore);
}
