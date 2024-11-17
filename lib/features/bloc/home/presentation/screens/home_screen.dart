import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base/features/bloc/home/presentation/bloc/first/first_bloc.dart';
import 'package:knowledge_base/features/bloc/home/presentation/bloc/second/second_bloc.dart';
import 'package:knowledge_base/features/bloc/home/presentation/screens/home_screen_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GetFirstListBloc>(create: (BuildContext context) => GetFirstListBloc()),
          BlocProvider<SecondBloc>(create: (context) => SecondBloc())
        ],
        child: const HomeScreenView(),
      ),
    );
  }
}
