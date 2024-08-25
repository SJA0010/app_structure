import 'package:app_structure/app_theme/text_theme.dart';
import 'package:app_structure/common/widgets/custom_text_button.dart';
import 'package:app_structure/features/sign_forms/pages/log_in.dart';
import 'package:app_structure/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    ColorScheme colorScheme(context) => Theme.of(context).colorScheme;
    final allUsers = userProvider.getAllUsers;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Home",
              style: appTextTheme.headlineMedium,
            ),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    // Call the signOut method
                    Provider.of<UserProvider>(context, listen: false).signOut();

                    // Navigate to the login screen after logging out
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ),
                    );
                  },
                  text: "Logout"),
              SizedBox(width: 10)
            ],
            bottom: TabBar(tabs: [
              Text("All Users"),
              Text("Profile"),
            ]),
          ),
          body: TabBarView(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme(context).outline,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '  Name: ',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text:
                                      userProvider.currentUser?.name ?? 'name',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  Email: ',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text:
                                      userProvider.currentUser?.name ?? 'Name',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  Password: ',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text: userProvider.currentUser?.password ??
                                      'Name',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  Phone: ',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text: userProvider.currentUser?.password ??
                                      'Name',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Welcome ${userProvider.currentUser?.name ?? 'Name'}",
                    style: appTextTheme.headlineLarge,
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme(context).outline,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '  Email :',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text:
                                      userProvider.currentUser?.name ?? 'Email',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  password :',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text: userProvider.currentUser?.password ??
                                      'Password',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  User Name :',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text: userProvider.currentUser?.name ??
                                      'User Name',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '  Phone :',
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                              children: [
                                TextSpan(
                                  text: userProvider.currentUser?.password ??
                                      'Unknown',
                                  style: TextStyle(
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
