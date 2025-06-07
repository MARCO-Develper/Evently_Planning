import 'package:flutter/material.dart';
import '../firebase/firebase_manager.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "RegisterScreen";

  RegisterScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is Required";
                    }
                    return null;
                  },
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).focusColor),
                    prefixIcon: const Icon(Icons.person),
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
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is Required";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);

                    if (!emailValid) {
                      return "Email is Not valid";
                    }

                    return null;
                  },
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "Email",
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
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required";
                    }
                    if (value.length < 6) {
                      return "Should be At least 6 Char";
                    }
                    return null;
                  },
                  obscureText: true,
                  obscuringCharacter: "#",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "Password",
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
                TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "RePassword is Required";
                    }
                    if (value.length < 6) {
                      return "Should be At least 6 Char";
                    }
                    if (passwordController.text != value) {
                      return " Password not matched";
                    }
                    return null;
                  },
                  obscureText: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).focusColor),
                  decoration: InputDecoration(
                    labelText: "Re Password",
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
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseManager.createUser(emailController.text,
                          passwordController.text, nameController.text, () {
                        Navigator.pop(context);

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (route) => false,
                        );
                      }, (message) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Something went wrong"),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          ),
                        );
                      }, () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    "Register",
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
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                            text: "I Have Account ? ",
                            style: Theme.of(context).textTheme.titleSmall),
                        TextSpan(
                          text: "Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
