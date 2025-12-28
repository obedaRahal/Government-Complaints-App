import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/auth/presentation/widget/common_top_part_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordNewPasswordView extends StatelessWidget {
  const ForgotPasswordNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ForgotPasswordNewPasswordViewBody()));
  }
}

class ForgotPasswordNewPasswordViewBody extends StatelessWidget {
  ForgotPasswordNewPasswordViewBody({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage ||
          prev.isSuccess != curr.isSuccess,
      listener: (context, state) {
        final route = ModalRoute.of(context);
        if (route == null || !route.isCurrent) return;
        if (state.errorMessage != null) {
          showTopSnackBar(
            context,
            message: state.errorMessage ?? context.l10n.unexpected_error,
            isSuccess: false,
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? context.l10n.password_updated_ok,
            isSuccess: true,
          );
          debugPrint("ForgetPasswordNewwwPassssssss success ✅");
          context.read<ForgotPasswordCubit>().resetStatus();
          context.goNamed(AppRouteRName.welcomeView);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTopPartForgetPassword(
                  title: context.l10n.new_password,
                  bodyText: context.l10n.new_password_description,
                  img: isDark ? AppImage.forgetPassDark3 : AppImage.forgetPass3,
                  imgHeight: SizeConfig.height * .3,
                ),

                SizedBox(height: SizeConfig.height * .04),

                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        AuthFieldLabel(
                          label: context.l10n.password_field, // ✅
                          hint: context.l10n.password_field_hint,
                          suffixIcon: state.isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          obscureText: state.isPasswordObscure,
                          onChanged: (value) {
                            context
                                .read<ForgotPasswordCubit>()
                                .newPasswordChanged(value);
                          },
                          onSuffixTap: () {
                            context
                                .read<ForgotPasswordCubit>()
                                .togglePasswordVisibility();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),

                        AuthFieldLabel(
                          label:
                              context.l10n.new_password_field, 
                          hint: context.l10n.new_password_field_hint,
                          suffixIcon: state.isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          obscureText: state.isPasswordObscure,
                          onChanged: (value) {
                            context
                                .read<ForgotPasswordCubit>()
                                .confirmPasswordChanged(value);
                          },
                          onSuffixTap: () {
                            context
                                .read<ForgotPasswordCubit>()
                                .togglePasswordVisibility();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.l10n.please_enter_password;
                            }
                            if (value.length < 6) {
                              return context.l10n.password_at_least;
                            }
                            if (value != state.newPassword) {
                              return context.l10n.passwords_not_match;
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: SizeConfig.height * .06),

                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButtonWidget(
                      width: double.infinity,
                      backgroundColor: theme.colorScheme.primary,
                      childHorizontalPad: SizeConfig.width * .07,
                      childVerticalPad: SizeConfig.height * .012,
                      borderRadius: 10,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context
                              .read<ForgotPasswordCubit>()
                              .submitNewPassword();
                          debugPrint("im at forgot NEW password submit 🔐");
                        }
                      },
                      child: CustomTextWidget(
                        context.l10n.confirm_entry,
                        fontSize: SizeConfig.height * .025,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
