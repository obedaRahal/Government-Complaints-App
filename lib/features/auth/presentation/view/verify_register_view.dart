import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/verify%20register/verify_register_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/verify%20register/verify_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyRegisterView extends StatelessWidget {
  const VerifyRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyRegisterCubit(),
      child: const Scaffold(body: SafeArea(child: VerifyRegisterViewBody())),
    );
  }
}

class VerifyRegisterViewBody extends StatelessWidget {
  const VerifyRegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyRegisterCubit , VerifyRegisterState>(listener: (context, state) {
      if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        } else if (state.isSuccess) {
          debugPrint(
            "im at VerifyRegisterViewBody view at BlocListener anddd Login success ✅",
          );

          //context.pushNamed(AppRouteRName.verifyRegisterView);
        }
      
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.height * .02),
          ArrowBack(),

          SizedBox(height: SizeConfig.height * .04),

          SvgPicture.asset(
            AppImage.splashLogo,
            height: SizeConfig.height * .07,
          ),
          CustomTextWidget(
            "تاكيد الحساب",
            fontSize: SizeConfig.diagonal * .045,
          ),
          CustomTextWidget(
            "عزيزي المستخدم يرجى منك تأكيد بريدك الالكتروني عن طريق ادخال الرمز المكون من ست ارقام علما انك ستفقد الرمز الخاص بك في حال المغادرة",
            fontSize: SizeConfig.diagonal * .025,
            color: AppColor.middleGrey,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: SizeConfig.height * .02),

          CustomBackgroundWithChild(
            borderRadius: BorderRadius.circular(20),
            width: double.infinity,
            backgroundColor: AppColor.lightPurple,
            child: CustomTextWidget("نحن نقوم باجراء احترازي فقط"),
          ),

          SizedBox(height: SizeConfig.height * .04),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget("ادخل الرمز", color: AppColor.black),
              BlocBuilder<VerifyRegisterCubit, VerifyRegisterState>(
                builder: (context, state) {
                  final minutes = (state.remainingSeconds ~/ 60)
                      .toString()
                      .padLeft(1, '0'); // أو 2 لو بدك 05:00
                  final seconds = (state.remainingSeconds % 60)
                      .toString()
                      .padLeft(2, '0');

                  return CustomTextWidget("$minutes:$seconds");
                },
              ),
            ],
          ),

          Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              errorTextDirection: TextDirection.rtl,
              appContext: context,
              length: 6,
              textStyle: TextStyle(
                fontSize: SizeConfig.height * .025,
                color: AppColor.black,
                fontFamily: AppFonts.reemKufi,
              ),
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: SizeConfig.height * .07,
                fieldWidth: SizeConfig.height * .07,
                activeFillColor: AppColor.grey,
                selectedFillColor: AppColor.grey,
                inactiveFillColor: AppColor.grey,
                inactiveColor: AppColor.lightPurple,
                selectedColor: AppColor.primary,
                activeColor: AppColor.primary,
                errorBorderColor: Colors.red,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {
                context.read<VerifyRegisterCubit>().otpChanged(value);
              },
              validator: (value) {
                if (value == null || value.length != 6) {
                  return 'أدخل الرمز المؤلف من 6 أرقام';
                }
                return null;
              },
            ),
          ),

          SizedBox(height: SizeConfig.height * .06),

          BlocBuilder<VerifyRegisterCubit, VerifyRegisterState>(
            builder: (context, state) {
              if (state.isSubmitting) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomButtonWidget(
                width: double.infinity,
                backgroundColor: AppColor.primary,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .012,
                borderRadius: 10,
                onTap: () {
                  context.read<VerifyRegisterCubit>().submitOtp();
                  debugPrint("im at confirm  verifyyyyy");
                },
                child: CustomTextWidget(
                  "تأكيد الإدخال",
                  fontSize: SizeConfig.height * .025,
                  color: AppColor.white,
                ),
              );
            },
          ),

          SizedBox(height: SizeConfig.height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidget(
                "لم تستلم رمز بعد ؟ ",
                fontSize: SizeConfig.diagonal * .018,
                color: AppColor.middleGrey,
              ),
              InkWell(
                onTap: () {
                  context.read<VerifyRegisterCubit>().resendCode();
                },
                child: CustomTextWidget(
                  "إعادة ارسال الرمز",
                  fontSize: SizeConfig.diagonal * .02,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    )
    
    ;
  }
}
