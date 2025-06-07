import 'package:easy_localization/easy_localization.dart';
import 'package:evently/widgets/language_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/base.dart';
import 'package:evently/login/login_connector.dart';
import 'package:evently/login/login_view_model.dart';
import 'package:evently/providers/AuthProvider.dart';
import 'package:evently/screens/home/home.dart';
import 'package:evently/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginConnector {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: emailController,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "email".tr(),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).focusColor),
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "password".tr(),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).focusColor),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "forgetPassword".tr(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.login(
                        emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    "login".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                            text: "don'tHaveAccount".tr(),
                            style: Theme.of(context).textTheme.titleSmall),
                        TextSpan(
                          onEnter: (event) {},
                          text: "createAccount".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        ),
                      ])),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 40,
                        endIndent: 10,
                        thickness: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      "or".tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10,
                        thickness: 1,
                        endIndent: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      viewModel.loginWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons/google.png",
                          width: 26,
                          height: 25.67,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "loginWithGoogle".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const LanguageToggleWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel initMyViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.routeName,
          (route) => false,
    );
  }

  // إضافة method لتحديث الـ UserProvider
  @override
  Future<void> updateUserProvider() async {
    var authProvider = Provider.of<UserProvider>(context, listen: false);
    await authProvider.initUser();
  }

  @override
  showLoading({String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void showError({String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? 'Error occurred')),
    );
  }

  @override
  hideLoading() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  showSuccess() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Successfully"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}