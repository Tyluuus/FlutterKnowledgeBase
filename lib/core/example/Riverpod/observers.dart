import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Override of two methods of provider observer.
class Observers extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {}

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);
  }
}
