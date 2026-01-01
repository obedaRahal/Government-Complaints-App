import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/auth/presentation/widget/tow_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LogInViewBody()));
  }
}

class LogInViewBody extends StatelessWidget {
  LogInViewBody({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final theme = Theme.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // if (state.errorMessage != null) {
        //   showTopSnackBar(
        //     context,
        //     message: state.errorMessage ?? context.l10n.unexpected_error,
        //     isSuccess: false,
        //   );
        // }

        if (state.errorMessage != null) {
          final msg = state.errorMessage!;

          // هنا تقدر تستخدم المطابقة اللي تناسب رسالتكم من الباك
          final bool isAccountLockedOrNeedVerify = msg.contains(
            'تم قفل حسابك لاسباب تتعلق بسياسة الاستخدام',
          );

          showTopSnackBar(
            context,
            message: msg,
            isSuccess: false,
            acceptClick: isAccountLockedOrNeedVerify,
            onTap: isAccountLockedOrNeedVerify
                ? () {
                    // روح لواجهة تأكيد الحساب
                    context.pushNamed(
                      AppRouteRName.verifyRegisterView,
                      extra: {
                        'email': state.email,
                        'autoResend': true,
                      },
                    );
                    debugPrint("go to verifyyyyyyyyyyyyyyyyyyyy");
                    debugPrint("and email is ${state.email}");
                  }
                : null,
            // ممكن تخلي مدته أطول شوي
            displayDuration: const Duration(seconds: 5),
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? context.l10n.login_success,
            isSuccess: true,
          );
          debugPrint("im at login view at BlocListener anddd Login success ✅");
          context.goNamed(AppRouteRName.homeView, extra: state.successMessage);
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
                  context.l10n.login,
                  fontSize: SizeConfig.diagonal * .045,
                ),
                CustomTextWidget(
                  context.l10n.login_description,
                  fontSize: SizeConfig.diagonal * (isEn ? .021 : .025),
                  color: AppColor.middleGrey,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: SizeConfig.height * .02),

                AuthFieldLabel(
                  label: context.l10n.email_field,
                  hint: context.l10n.email_field_hint,
                  suffixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,

                  onChanged: (value) {
                    context.read<LoginCubit>().emailChanged(value);
                    debugPrint("im at email field and val isss $value");
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.please_enter_email;
                    }
                    return null;
                  },
                ),

                SizedBox(height: SizeConfig.height * .01),

                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return AuthFieldLabel(
                      label: context.l10n.password_field,
                      hint: context.l10n.password_field_hint,
                      suffixIcon: state.isPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      obscureText: state.isPasswordObscure,
                      onChanged: (value) {
                        context.read<LoginCubit>().passwordChanged(value);
                        debugPrint("im at passss field and val isss $value");
                      },
                      onSuffixTap: () {
                        context.read<LoginCubit>().togglePasswordVisibility();
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

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppRouteRName.forgotPasswordEmailView);
                    },
                    child: CustomTextWidget(
                      context.l10n.did_you_forget_password,
                      fontSize: SizeConfig.diagonal * (isEn ? .027 : .03),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.height * .06),

                BlocBuilder<LoginCubit, LoginState>(
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
                          debugPrint("im at confirm log innnnnn");
                          context.read<LoginCubit>().loginSubmitted();
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
                  text: context.l10n.didnt_have_account,
                  actionText: context.l10n.new_account,
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).replaceNamed(AppRouteRName.registerView);
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
