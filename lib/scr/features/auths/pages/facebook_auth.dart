import 'package:app_structure/scr/app_theme/color_scheme.dart';
import 'package:app_structure/scr/app_theme/text_theme.dart';
import 'package:app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:app_structure/scr/features/auths/controllers/fb_provider.dart';
import 'package:app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:app_structure/scr/features/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  @override
  Widget build(BuildContext context) {
    final facebookProvider = Provider.of<FacebookSignInProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Firebase Authentications",
          style: appTextTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Facebook Sign In",
                  style: appTextTheme.displaySmall,
                ),
              ),
              SizedBox(height: 20),
              CustomTextButton(
                backgroundColor: Colors.blue[700],
                onPressed: () {
                  facebookProvider.signInWithFacebook().then((_) {
                    if (facebookProvider.user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } else if (facebookProvider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(facebookProvider.errorMessage!)),
                      );
                    }
                  });
                },
                text: "Sign In",
              ),
              SizedBox(height: 150),
              Text(
                "------------or SignIn with------------",
                style: appTextTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  CustomTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpAuth(),
                        ),
                      );
                    },
                    text: "Phone",
                    backgroundColor: appDarkColorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirebaseSignUp(),
                        ),
                      );
                    },
                    text: "Google",
                    backgroundColor: Colors.red[800],
                  ),
                  const SizedBox(width: 10),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirebaseSignUp(),
                        ),
                      );
                    },
                    text: "Firebase Sign-up",
                    backgroundColor: Colors.green[800],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
