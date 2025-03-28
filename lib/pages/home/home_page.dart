import 'package:eassist_tools_app/pages/dashboard/dashboard_main.dart';
import 'package:eassist_tools_app/pages/onboard/onboard_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_bloc.dart';
import 'package:eassist_tools_app/common/size_config.dart';
import 'package:eassist_tools_app/pages/base/base_container.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

class HomePage extends StatefulWidget {
  final int userid;
  final UserRepository userRepository;

  const HomePage(
      {required super.key, required this.userid, required this.userRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  


  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(
          create: (content) => ProfileBloc(
              userRepository: widget.userRepository, id: widget.userid),
        )
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          SizeConfig().init(context);
          debugPrint("state : $state");
          if (state is HomePageActive) {            
            return const PageContainer(pageType: PageType.home);
            // return const OnboardMainPage();
          } else if (state is RoomCariPageActive) {            
            return const PageContainer(pageType: PageType.roomchat);
          } else if (state is ChangePasswordPageActive) {            
            return const PageContainer(pageType: PageType.changepswd);  
          } else if (state is SimulMVPageActive) {            
            return const PageContainer(pageType: PageType.simulmv);  
          } else if (state is SimulPARPageActive) {            
            return const PageContainer(pageType: PageType.simulpar);  
          } else if (state is SimulEEIPageActive) {            
            return const PageContainer(pageType: PageType.simuleei);  
          } else if (state is ProfilePageActive) {
            return PageContainerWithUserRepository(
              pageType: PageType.profile,
              userRepository: widget.userRepository,
              userid: widget.userid,
              key: null,
            );
          }
          return Container();
        },
      ),
    );
  }

}
