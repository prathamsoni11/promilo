import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:promilo/cloud_functions/auth_functions.dart';
import 'package:promilo/screens/dashboard_screen.dart';
import 'package:promilo/utils/assets.dart';
import 'package:promilo/utils/colors.dart';
import 'package:promilo/utils/sized_boxes.dart';
import 'package:promilo/widgets/icon_button.dart';
import 'package:promilo/widgets/label_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier _submitButtonEnabled = ValueNotifier(false);
  final TextEditingController _emailOrMobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthFunctions _authFunctions = AuthFunctions();
  @override
  void dispose() {
    _submitButtonEnabled.dispose();
    _emailOrMobController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<http.Response?> _oAuth() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      http.Response res = await _authFunctions.oAuth(
          _emailOrMobController.text, _passwordController.text);
      return res;
    } catch (err) {
      _showSnackBar(err.toString());
      return null;
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  _validateEmailOrMobAndPassword() {
    if (RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
            .hasMatch(_emailOrMobController.text) &&
        _passwordController.text.length >= 8) {
      _submitButtonEnabled.value = true;
    } else {
      _submitButtonEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "promilo",
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSizedBoxes.height40,
                Text(
                  "Hi, Welcome Back!",
                  style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.text100),
                  textAlign: TextAlign.center,
                ),
                AppSizedBoxes.height40,
                LabelTextField(
                  controller: _emailOrMobController,
                  label: "Please Sign in to continue",
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Email or Mob No.",
                  onChanged: (value) {
                    _validateEmailOrMobAndPassword();
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in With OTP",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textButton,
                      ),
                    ),
                  ),
                ),
                LabelTextField(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                  hintText: "Enter Password",
                  onChanged: (value) {
                    _validateEmailOrMobAndPassword();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {},
                        ),
                        const Text(
                          "Remember Me",
                          style: TextStyle(color: AppColors.text200),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password",
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textButton,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AppSizedBoxes.height20,
                ValueListenableBuilder(
                  valueListenable: _submitButtonEnabled,
                  builder: (BuildContext context, value, Widget? child) {
                    return ElevatedButton(
                      onPressed: value
                          ? () async {
                              _oAuth().then(
                                (response) {
                                  if (response == null) {
                                    return;
                                  }
                                  if (mounted && response.statusCode == 200) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardScreen()),
                                      (route) => false,
                                    );
                                  } else if (mounted) {
                                    String message =
                                        jsonDecode(response.body)["status"]
                                                ["message"]
                                            .toString();
                                    _showSnackBar(message);
                                  }
                                },
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
                AppSizedBoxes.height40,
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("or"),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                AppSizedBoxes.height20,
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  children: [
                    AppIconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.googleIconSvg),
                      iconSize: 44,
                    ),
                    AppIconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.linkedinIconSvg),
                      iconSize: 44,
                    ),
                    AppIconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.facebookIconSvg),
                      iconSize: 44,
                    ),
                    AppIconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.instagramIconSvg),
                      iconSize: 44,
                    ),
                    AppIconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.whatsappIconSvg),
                      iconSize: 44,
                    ),
                  ],
                ),
                AppSizedBoxes.height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionSection(
                      actionText: "Business User?",
                      buttonText: "Login here",
                      onPressed: () {},
                    ),
                    _buildActionSection(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      actionText: "Don't have an account",
                      buttonText: "Sign Up",
                      onPressed: () {},
                    ),
                  ],
                ),
                AppSizedBoxes.height30,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By continuing, you agree to\n",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      color: AppColors.text300,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      const TextSpan(text: "Promilo's "),
                      TextSpan(
                        text: "Terms of Use & Privacy Policy.",
                        style: const TextStyle(
                          color: AppColors.black,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                AppSizedBoxes.height20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionSection({
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    required String actionText,
    required String buttonText,
    required void Function()? onPressed,
  }) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: crossAxisAlignment,
      spacing: 6,
      children: [
        Text(
          actionText,
          style: const TextStyle(color: AppColors.text200),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textButton,
                ),
          ),
        ),
      ],
    );
  }

  _showSnackBar(String message) {
    if (mounted) {
      var snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
