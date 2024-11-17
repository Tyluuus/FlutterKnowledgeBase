import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/home_state_notifier_provider.dart';
import 'package:knowledge_base/shared/network/example/network_values.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(firstStateNotifier.notifier).getFirstList(type: EndPoints.main);
    });
    scrollController.addListener(firstScrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(firstScrollListener);
  }

  ScrollController scrollController = ScrollController();

  void firstScrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      ref.read(firstStateNotifier.notifier).getFirstList(type: EndPoints.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
            child: Column(
          children: [
            // Some UI definition
            Container(),
          ],
        )),
      ]),
    );
  }
}
