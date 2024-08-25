import 'package:app_structure/app_theme/color_scheme.dart';
import 'package:app_structure/app_theme/text_theme.dart';
import 'package:app_structure/common/widgets/custom_button.dart';
import 'package:app_structure/common/widgets/custom_text_button.dart';
import 'package:app_structure/common/widgets/custom_text_field.dart';
import 'package:app_structure/features/sign_forms/controllers/controllers.dart';
import 'package:app_structure/features/sign_forms/pages/home.dart';
import 'package:app_structure/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  void onSignInButtonPressed(String email, String password) async {
    context.loaderOverlay.show();

    await Future.delayed(const Duration(seconds: 2));

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isAuthenticated = await userProvider.signIn(email, password);

    context.loaderOverlay.hide();

    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Global 2.0",
          style: appTextTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Text("Log In", style: appTextTheme.displayLarge),
                ),
                const SizedBox(height: 70),
                CustomTextFormField(
                  controller: AppTextControllers.instance.emailController,
                  hint: "Email",
                  focusBorderColor: Colors.blue,
                  keyboardType: TextInputType.text,
                  validationType: ValidationType.email,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: AppTextControllers.instance.passwordController,
                  hint: "password",
                  focusBorderColor: Colors.blue,
                  validationType: ValidationType.password,
                ),
                const SizedBox(height: 30),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email =
                          AppTextControllers.instance.emailController.text;
                      String password =
                          AppTextControllers.instance.passwordController.text;

                      onSignInButtonPressed(email, password);
                    }
                  },
                  text: "Sign Up",
                ),
                const SizedBox(height: 80),
                Text(
                  "------------or SignIn with------------",
                  style: appTextTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    CustomTextButton(
                      onPressed: () {},
                      text: "Google",
                      backgroundColor: Colors.red[600],
                    ),
                    const SizedBox(width: 10),
                    CustomTextButton(
                      onPressed: () {},
                      text: "Phone",
                      backgroundColor: appDarkColorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    CustomTextButton(
                      onPressed: () {},
                      text: "Facebook",
                      backgroundColor: Colors.blue[700],
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have a Account ? "),
                    CustomTextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SignUp(),
                        //   ),
                        // );
                      },
                      text: "Create now",
                      backgroundColor: Colors.transparent,
                      textColor: Theme.of(context).colorScheme.onSurface,
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
