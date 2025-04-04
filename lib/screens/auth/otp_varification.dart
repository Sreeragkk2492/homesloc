// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/core/widgets/auth_button/auth_button.dart';
import 'package:homesloc/screens/auth/sign_up.dart';
import 'package:homesloc/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:pinput/pinput.dart';

class OtpVarification extends StatelessWidget {
  const OtpVarification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: PinputExample(),
      ),
    );
  }
}

class PinputExample extends StatefulWidget {
  const PinputExample({super.key});

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle:
          TextStyle(fontSize: 18.sp, color: black, fontFamily: 'Poppins'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: blue),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 38.h, left: 3.w),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: black,
                size: 30.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70.h),
            child: Center(
              child: Text(
                'Verify Code',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              'Please enter the code we just sent to email.',
              style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xffD7C7C7)),
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 5,
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => SizedBox(width: 15.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your pin';
                      }
                      return null;
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: Color(0xffF5F2F2),
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(19.sp),
                        border: Border.all(
                          color: blue,
                        ),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: white,
                        borderRadius: BorderRadius.circular(19.sp),
                        border: Border.all(color: blue),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  "Didn't receive OTP?",
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffD7C7C7)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Resend code',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 11.sp,
                      color: blue),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AuthButton(
                  name: 'Verify',
                  onPressed: () {
                    focusNode.unfocus();
                    formKey.currentState!.validate();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BottomBarScreen();
                    }));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
