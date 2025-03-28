import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/pages/home/home.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> with RouteAware {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocConsumer<OnBoardMenuCariBloc, OnBoardMenuCariState>(
      builder: (context, state) {
        debugPrint(
            "AppMenuState -> state.hasPassedBriefing : ${state.hasPassedBriefing}");
        return Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      currentAccountPictureSize: const Size.square(100),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/login_logo.png'),
                      ),
                      accountEmail: const Text("support@ptssk.id"),
                      accountName: Text(AppData.personName),
                      onDetailsPressed: () {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.of(context).pop();
                          homeBloc.add(ProfilePageActiveEvent());
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text("Home"),
                      //selected: _activeRoute == AppRoutes.homePage,
                      onTap: () {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.of(context).pop();
                          homeBloc.add(HomePageActiveEvent());
                        });
                      },
                    ),
                    ExpansionTile(
                      leading: const Icon(
                        Icons.settings,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.0,
                      ),
                      title: const Text(
                        "Simulasi Premi",
                        style: TextStyle(),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Kendaraan"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulMVPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Property"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulPARPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Gold in Transit"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulGITPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Gold in Cash"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulGISPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("BON"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulBONPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("WP"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulWPPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Electronic"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(SimulEEIPageActiveEvent());                                
                              });
                              
                            },
                          ),
                        ),
                        
                      ],
                    ),
                    
                    ExpansionTile(
                      leading: const Icon(
                        Icons.settings,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.0,
                      ),
                      title: const Text(
                        "User Security",
                        style: TextStyle(),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Profile"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(ProfilePageActiveEvent());
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ListTile(
                            leading: const Icon(Icons.security),
                            title: const Text("Change Password"),
                            //selected: _activeRoute == AppRoutes.homePage,
                            onTap: () {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Navigator.of(context).pop();
                                homeBloc.add(ChangePasswordPageActiveEvent());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: const Text("Chat Support"),
                      //selected: _activeRoute == AppRoutes.homePage,
                      onTap: () {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.of(context).pop();
                          homeBloc.add(RoomCariPageActiveEvent());
                        });
                      },
                    ),
                    AboutListTile(
                      icon: const Icon(Icons.info),
                      applicationName: "JPS Calculator",
                      aboutBoxChildren: <Widget>[
                        const Text(
                          "http://www.jayaproteksindo.co.id/",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "version : ${AppData.version}",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Logout"),
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                      },
                    ),
                  ],
                ),
              );
      },
      buildWhen: (previous, current) {
        return (previous.hasPassedBriefing != current.hasPassedBriefing);
      },
      listener: (BuildContext context, OnBoardMenuCariState state) {},
    );
  }
}
