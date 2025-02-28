import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PromoCodeTextField extends StatelessWidget {
  final TextEditingController? controller;

  const PromoCodeTextField({
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: context.locale.enterPromoCode,
        labelStyle: TextStyle(
          color: colors.grey500,
        ),
        fillColor: colors.primaryBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: colors.grey500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: colors.primaryBg,
          ),
        ),
        prefixIcon: Icon(
          Icons.local_offer,
          color: colors.primaryBg,
        ),
      ),
    );
  }
}
