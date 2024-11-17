import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/first_notifier.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/first_state.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/second_notifier.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/second_state.dart';

final firstStateNotifier = AutoDisposeStateNotifierProvider<FirstNotifier, FirstState>((ref) => FirstNotifier());

final secondStateNotifier = AutoDisposeStateNotifierProvider<SecondNotifier, SecondState>((ref) => SecondNotifier());
