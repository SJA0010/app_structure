import 'package:app_structure/app_theme/theme_notifier.dart';
import 'package:app_structure/common/widgets/custom_button.dart';
import 'package:app_structure/common/widgets/custom_text_button.dart';
import 'package:app_structure/common/widgets/custom_text_field.dart';
import 'package:app_structure/features/sign_forms/controllers/controllers.dart';
import 'package:app_structure/features/sign_forms/pages/log_in.dart';
import 'package:app_structure/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const SignUp({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //bool switchVal = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool switchVal = themeNotifier.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Global 2.0",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Switch(
            inactiveTrackColor: Colors.white,
            onChanged: (bool value) {
              themeNotifier.toggleTheme(value);
            },
            value: switchVal,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: 100),
                CustomTextFormField(
                  hint: "full name",
                  focusBorderColor: Colors.blue,
                  controller: AppTextControllers.instance.usernameController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hint: "Email",
                  focusBorderColor: Colors.blue,
                  keyboardType: TextInputType.text,
                  controller: AppTextControllers.instance.emailController,
                  validationType: ValidationType.email,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hint: "password",
                  focusBorderColor: Colors.blue,
                  controller: AppTextControllers.instance.passwordController,
                  validationType: ValidationType.password,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hint: "Phone Number",
                  focusBorderColor: Colors.blue,
                  keyboardType: TextInputType.phone,
                  controller: AppTextControllers.instance.phoneController,
                  validationType: ValidationType.phoneNumber,
                ),
                const SizedBox(height: 35),
                CustomElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context.loaderOverlay.show();

                      await Future.delayed(Duration(seconds: 2));

                      String name =
                          AppTextControllers.instance.usernameController.text;
                      String email =
                          AppTextControllers.instance.emailController.text;
                      String password =
                          AppTextControllers.instance.passwordController.text;

                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      await userProvider.registerUser(
                        name,
                        email,
                        password,
                      );

                      context.loaderOverlay.hide();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogIn(),
                        ),
                      );
                    }
                  },
                  text: "Sign Up",
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      },
                      text: "Log in",
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
