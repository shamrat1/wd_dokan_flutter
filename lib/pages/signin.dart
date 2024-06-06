import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dokan/main.dart';
import 'package:dokan/models/social_icon_button.dart';
import 'package:dokan/pages/home.dart';
import 'package:dokan/pages/signup.dart';
import 'package:dokan/repositories/auth_repositories.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/custom_textfields.dart';
import 'package:dokan/utils/storage/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String? _nameError;
  String? _passwordError;

  bool _validate() {
    if (_nameController.text == "") {
      _nameError = "Username is required";
    } else {
      _nameError = null;
    }
    if (_passwordController.text == "") {
      _passwordError = "Password is required";
    } else {
      _passwordError = null;
    }
    setState(() {});

    if (_nameError == null && _passwordError == null) {
      return true;
    }
    return false;
  }

  void _login() async {
    try {
      if (_validate()) {
        setState(() {
          _loading = true;
        });
        var response = await AuthRepositories().login({
          "username": _nameController.text,
          "password": _passwordController.text,
        });
        SharedPrefs.setBool("authenticated", true);
        SharedPrefs.setString("token", response.token ?? "");
        SharedPrefs.setString("username", response.userDisplayName ?? "");
        SharedPrefs.setString("email", response.userEmail ?? "");

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const LandingPage()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login successful."),
          ),
        );
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection."),
          backgroundColor: Colors.red,
        ),
      );
    } on DioException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Entered credentials are not valid",
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print("from normal exception");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
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
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _nameController,
                      prefixIcon: Icons.person_outline_rounded,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      hintText: "Username",
                    ),
                    _errorWidget(_nameError),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _passwordController,
                      prefixIcon: Icons.lock_outline_rounded,
                      textInputAction: TextInputAction.done,
                      obsecureText: true,
                      hintText: "Password",
                    ),
                    _errorWidget(_passwordError),
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
                    if (_loading) return;
                    _login();
                  },
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
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
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const SignupPage())),
                  child: Text(
                    "Create New Account",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: TColors.darkerGrey,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
