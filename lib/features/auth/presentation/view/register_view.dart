import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/auth/presentation/widget/tow_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: RegisterViewBody()));
  }
}

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final theme = Theme.of(context);
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
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
            message: state.successMessage ?? context.l10n.success,
            isSuccess: true,
          );
          debugPrint(
            "im at registerrr view at BlocListener anddd register success ✅",
          );
          context.pushNamed(
            AppRouteRName.verifyRegisterView,
            extra: state.email,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * .02),
                ArrowBack(),

                SizedBox(height: SizeConfig.height * .04),

                SvgPicture.asset(
                  isDark ? AppImage.splashLogoDark : AppImage.splashLogo,
                  height: SizeConfig.height * .07,
                ),
                CustomTextWidget(
                  context.l10n.signup,
                  fontSize: SizeConfig.diagonal * .045,
                ),
                CustomTextWidget(
                  context.l10n.signup_description,
                  fontSize: SizeConfig.diagonal * (isEn ? .021 : .025),
                  color: AppColor.middleGrey,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: SizeConfig.height * .02),

                AuthFieldLabel(
                  label: context.l10n.name_field,
                  hint: context.l10n.name_field_hint,
                  suffixIcon: Icons.person_2_outlined,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    context.read<RegisterCubit>().nameChanged(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.please_enter_name;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height * .01),

                AuthFieldLabel(
                  label: context.l10n.email_field, // ✅
                  hint: context.l10n.email_field_hint,
                  suffixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    context.read<RegisterCubit>().emailChanged(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.please_enter_email;
                    }
                    return null;
                  },
                ),

                SizedBox(height: SizeConfig.height * .01),

                AuthFieldLabel(
                  label: context.l10n.national_number_field, // ✅
                  hint: context.l10n.national_number_field_hint,
                  suffixIcon: Icons.format_list_numbered_sharp,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    context.read<RegisterCubit>().idNumberChanged(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.please_enter_national_number;
                    }
                    if (value.length != 11) {
                      return context.l10n.national_number_atleast;
                    }
                    return null;
                  },
                ),

                SizedBox(height: SizeConfig.height * .01),

                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return AuthFieldLabel(
                      label: context.l10n.password_field, // ✅
                      hint: context.l10n.password_field_hint,
                      suffixIcon: state.isPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      obscureText: state.isPasswordObscure,
                      onChanged: (value) {
                        context.read<RegisterCubit>().passwordChanged(value);
                      },
                      onSuffixTap: () {
                        context
                            .read<RegisterCubit>()
                            .togglePasswordVisibility();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.please_enter_password;
                        }
                        if (value.length < 6) {
                          return context.l10n.password_at_least;
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: SizeConfig.height * .06),

                BlocBuilder<RegisterCubit, RegisterState>(
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
                          debugPrint("confirmmmm  registerrrr");
                          context.read<RegisterCubit>().registerSubmitted();
                        } else {
                          debugPrint("form not validddddd");
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

                SizedBox(height: SizeConfig.height * .02),

                TowTextRow(
                  text: context.l10n.did_you_have_account,
                  actionText: context.l10n.login,
                  onTap: () {
                    GoRouter.of(context).replaceNamed(AppRouteRName.loginView);
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
