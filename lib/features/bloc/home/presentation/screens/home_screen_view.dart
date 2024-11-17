import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base/features/bloc/home/presentation/bloc/first/first_bloc.dart';
import 'package:knowledge_base/shared/network/example/network_values.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<GetFirstListBloc>().add(const GetFistListEvent(type: EndPoints.main));
    scrollControl.addListener(firstScrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollControl.removeListener(firstScrollListener);
  }

  ScrollController scrollControl = ScrollController();

  void firstScrollListener() {
    if (scrollControl.position.maxScrollExtent == scrollControl.offset) {
      context.read<GetFirstListBloc>().add(const GetFistListEvent(type: EndPoints.main));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: scrollControl, slivers: [
      SliverToBoxAdapter(
          child: Column(
        children: [
          Container(),
        ],
      )),
    ]);
  }
}
