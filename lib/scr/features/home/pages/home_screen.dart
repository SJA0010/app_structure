import 'package:app_structure/scr/app_theme/color_scheme.dart';
import 'package:app_structure/scr/app_theme/text_theme.dart';
import 'package:app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:app_structure/scr/features/home/controllers/greeting_provider.dart';
import 'package:app_structure/scr/features/home/controllers/home_provider.dart';
import 'package:app_structure/scr/models/staticdata.dart';
import 'package:app_structure/scr/models/user_model.dart';
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

    void _showEditDialog(BuildContext context, UserModel user) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      TextEditingController nameController =
          TextEditingController(text: user.userName);
      TextEditingController emailController =
          TextEditingController(text: user.email);
      TextEditingController phoneController =
          TextEditingController(text: user.phone);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  homeProvider.updateUser(
                    user.userid,
                    {
                      'userName': nameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                    },
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ],
          );
        },
      );
    }

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
            bottom: TabBar(tabs: [
              Text(
                "profile",
              ),
              Text(
                "Add friends",
              )
            ]),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: appDarkColorScheme.primary)),
                  child: Text(
                    textAlign: TextAlign.center,
                    "  ${greeting}  \nDear ${Staticdata.model?.userName}",
                    style: appTextTheme.displaySmall,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: homeProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: homeProvider.allUsers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 170,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _showEditDialog(context,
                                                homeProvider.allUsers[index]);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.red[800],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            homeProvider.deleteUser(homeProvider
                                                .allUsers[index].userid);
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red[800],
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                .allUsers[index]?.password,
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
              ),
            ],
          ),
        ));
  }
}
