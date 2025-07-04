import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../hero_client_page/hero_user_main.dart';
import '../heropage/hero_main.dart';

class LoadingUser2Page extends StatefulWidget {
  const LoadingUser2Page({super.key});

  @override
  State<LoadingUser2Page> createState() => _LoadingUser2PageState();
}

class _LoadingUser2PageState extends State<LoadingUser2Page> {
  @override
  void initState() {
    super.initState();

    // Delay sebentar, lalu dispatch event dan pindah halaman


      // Trigger event ke HomeBloc
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(HeroPageActiveEvent());
    });

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
