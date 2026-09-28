import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';
import 'daily_buttons.dart';

class DailyCard extends StatelessWidget {
  const DailyCard({
    required this.child,
    this.onTap,
    this.semanticLabel,
    super.key,
  });
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  @override
  Widget build(BuildContext context) => Semantics(
    button: onTap != null,
    onTap: semanticLabel == null ? null : onTap,
    label: semanticLabel,
    excludeSemantics: semanticLabel != null,
    child: Card(
      child: InkWell(onTap: onTap, child: child),
    ),
  );
}

class InfoSectionCard extends StatelessWidget {
  const InfoSectionCard({required this.title, required this.child, super.key});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => DailyCard(
    child: Padding(
      padding: const EdgeInsetsDirectional.all(DailySpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: DailySpacing.sm),
          child,
        ],
      ),
    ),
  );
}

class DailyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DailyAppBar({
    required this.title,
    this.leading,
    this.actions,
    super.key,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) =>
      AppBar(title: Text(title), leading: leading, actions: actions);
}

abstract final class DailyBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) => showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: DailyLayout.formMaxWidth),
    sheetAnimationStyle: AnimationStyle(
      duration: DailyMotion.duration(context, DailyMotion.complex),
      reverseDuration: DailyMotion.duration(context, DailyMotion.standard),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(DailySpacing.md),
            child: builder(context),
          ),
        ),
      ),
    ),
  );
}

abstract final class DailyDialog {
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    String cancelLabel = 'Batal',
    bool destructive = false,
  }) async =>
      await showDialog<bool>(
        context: context,
        barrierColor: context.dailyColors.scrim,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text(title),
          content: Text(message),
          actions: [
            DailyTextButton(
              label: cancelLabel,
              onPressed: () => Navigator.pop(context, false),
            ),
            DailyPrimaryButton(
              label: confirmLabel,
              destructive: destructive,
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ) ??
      false;
}
