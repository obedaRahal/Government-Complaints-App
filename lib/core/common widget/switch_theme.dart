import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_cubit.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.mode == ThemeMode.dark;
        final theme = Theme.of(context);

        final label = isDark ? context.l10n.dark_mode : context.l10n.light_mode;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          title: CustomTextWidget(
            label,
            color: theme.colorScheme.secondary,
            fontSize: 22,
            textAlign: TextAlign.start,
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().change(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
          onTap: () => context.read<ThemeCubit>().toggleLightDark(),
        );
      },
    );
  }
}
