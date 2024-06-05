import 'package:dokan/models/social_icon_button.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/custom_textfields.dart';
import 'package:dokan/utils/constants/shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:string_validator/string_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _validate() {
    if (_nameController.text == "") {
      _nameError = "Name is required";
    } else {
      _nameError = null;
    }
    if (_emailController.text == "") {
      _emailError = "Email is required";
    } else if (!isEmail(_emailController.text)) {
      _emailError = "Enter a valid email address";
    } else {
      _emailError = null;
    }
    if (_passwordController.text == "") {
      _passwordError = "Password is required";
    } else if (_passwordController.text.length < 6) {
      _passwordError = "Password should be at least 6 characters long.";
    } else {
      _passwordError = null;
    }
    if (_confirmPasswordController.text == "") {
      _confirmPasswordError = "Confirm Password is required";
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _confirmPasswordError = "Passwords don't match. Try again.";
    } else {
      _confirmPasswordError = null;
    }
    print(_confirmPasswordError);
    setState(() {});

    if (_nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      return true;
    }
    return false;
  }

  Widget _errorWidget(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: TShadows.primaryBoxShadow,
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 30.h,
                        color: TColors.darkGrey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(6.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: TColors.primary,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    color: Colors.black.withOpacity(0.25))
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: TColors.white,
                              size: 15.h,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 19.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _nameController,
                      prefixIcon: Icons.person_outline_rounded,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      hintText: "Name",
                    ),
                    _errorWidget(_nameError),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 19.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _emailController,
                      prefixIcon: Icons.email_outlined,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      hintText: "Email",
                    ),
                    _errorWidget(_emailError),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 19.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _passwordController,
                      prefixIcon: Icons.lock_outline_rounded,
                      textInputAction: TextInputAction.next,
                      obsecureText: true,
                      hintText: "Password",
                    ),
                    _errorWidget(_passwordError),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 19.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _confirmPasswordController,
                      prefixIcon: Icons.lock_outline_rounded,
                      textInputAction: TextInputAction.done,
                      obsecureText: true,
                      hintText: "Confirm Password",
                    ),
                    _errorWidget(_confirmPasswordError),
                  ],
                ),
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
                  onPressed: () {
                    print(_validate());
                  },
                  child: const Text("Sign Up"),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: TColors.darkerGrey,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
