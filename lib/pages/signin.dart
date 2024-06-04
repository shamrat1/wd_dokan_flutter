import 'package:dokan/models/social_icon_button.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/custom_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:string_validator/string_validator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 83.h),
                  child: Image.asset(
                    "assets/logo.png",
                    height: 50.h,
                    width: 165.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: TCustomTextFields.textFieldOne(
                      context, _emailController,
                      prefixIcon: Icons.email_outlined,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      hintText: "Email", validator: (value) {
                    if (value == null) {
                      return "Email is required.";
                    }
                    if (!isEmail(value)) {
                      return "Email is invalid.";
                    }
                    return null;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: TCustomTextFields.textFieldOne(
                      context, _passwordController,
                      prefixIcon: Icons.lock_outline_rounded,
                      textInputAction: TextInputAction.done,
                      obsecureText: true,
                      hintText: "Password", validator: (value) {
                    if (value == null) {
                      return "Password is required.";
                    }
                    if (value.length < 6) {
                      return "Password should be of at least 6 characters.";
                    }
                    return null;
                  }),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Login"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 55.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const SocialIconButton(
                            assetImageURL: "assets/facebook.png"),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const SocialIconButton(
                            assetImageURL: "assets/google.png"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 55.h),
                  child: Text(
                    "Create New Account",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: TColors.darkerGrey,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
