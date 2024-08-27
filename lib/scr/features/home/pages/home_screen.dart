import 'package:app_structure/scr/app_theme/text_theme.dart';
import 'package:app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:app_structure/scr/features/home/controllers/greeting_provider.dart';
import 'package:app_structure/scr/features/home/controllers/home_provider.dart';
import 'package:app_structure/scr/models/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Fetch the list of users when the Home screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme(context) => Theme.of(context).colorScheme;
    final greeting = Provider.of<GreetingProvider>(context).greeting;
    final homeProvider = Provider.of<HomeProvider>(context);

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
                    Staticdata.signOut(context);
                  },
                  text: "Logout"),
              const SizedBox(width: 10)
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Welcome and ${greeting} ${Staticdata.model?.userName}",
                  style: appTextTheme.displaySmall,
                ),
                homeProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: homeProvider.allUsers.length,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: '  Name: ',
                                        style: appTextTheme.titleSmall
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .primary),
                                        children: [
                                          TextSpan(
                                            text: homeProvider
                                                .allUsers[index].userName!,
                                            style: TextStyle(
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '  Email: ',
                                        style: appTextTheme.titleSmall
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .primary),
                                        children: [
                                          TextSpan(
                                            text: homeProvider
                                                .allUsers[index].email!,
                                            style: TextStyle(
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '  Password: ',
                                        style: appTextTheme.titleSmall
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .primary),
                                        children: [
                                          TextSpan(
                                            text: homeProvider
                                                .allUsers[index].password!,
                                            style: TextStyle(
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '  Phone: ',
                                        style: appTextTheme.titleSmall
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .primary),
                                        children: [
                                          TextSpan(
                                            text: homeProvider
                                                .allUsers[index].phone!,
                                            style: TextStyle(
                                                color: colorScheme(context)
                                                    .onSurface),
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
              ],
            ),
          ),
        ));
  }
}
