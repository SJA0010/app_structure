import 'package:app_structure/scr/app_theme/color_scheme.dart';
import 'package:app_structure/scr/app_theme/text_theme.dart';
import 'package:app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:app_structure/scr/features/auths/pages/otp_auth.dart';
import 'package:app_structure/scr/features/firebase_sign/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  Future facebookSignIn() async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () async {
                  User? user = await facebookSignIn();
                  if (user != null) {
                    print('Successfully signed in with Facebook!');
                    print('User: ${user.displayName}');
                  } else {
                    print('Failed to sign in with Facebook');
                  }
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
