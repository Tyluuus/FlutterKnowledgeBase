
## Core concepts

### Streams

We can create a Stream in Dart by writing an async* (async generator) function.

```dart
Stream<int> countStream(int max) async* {
    for (int i = 0; i < max; i++) {
        yield i;
    }
}
```
Every time we yield in an async* function we are pushing that piece of data through the Stream.

### Cubit
A Cubit is a class which extends BlocBase and can be extended to manage any type of state.
A Cubit can expose functions which can be invoked to trigger state changes.

We can observe cubit and its state changes by overriding onChange method like below:
```dart
@override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
```

We can also have access to all changes by extending bloc observer like below:
```dart
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}
```

we then need to change observer for our bloc (for example in main.dart) by:
```dart
  Bloc.observer = SimpleBlocObserver();
```


We can also react on errors by extending onError like below:
```dart
@override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
```

### Blocs

A Bloc is a more advanced class which relies on events to trigger state changes rather than functions. 
Bloc also extends BlocBase which means it has a similar public API as Cubit. 
However, rather than calling a function on a Bloc and directly emitting a new state, 
Blocs receive events and convert the incoming events into outgoing states.

Example of bloc:
```dart
sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);
}
```
Bloc requires us to register event handlers via the on<Event> API, as opposed to functions in Cubit.
An event handler is responsible for converting any incoming events into zero or more outgoing states.

```dart
sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });
  }
}
```

Important: 
* Blocs should never directly emit new states. Instead every state change must be output in 
  response to an incoming event within an EventHandler.
* Both blocs and cubits will ignore duplicate states. If we emit State nextState where state == 
  nextState, then no state change will occur.

Like with cubits we can observe Bloc on state changes. One key differentiating factor between 
Bloc and Cubit is that because Bloc is event-driven, we are also able to capture information 
about what triggered the state change. We can do this by overriding onTransition.

```dart
@override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print(transition);
  }
```

Another unique feature of Bloc instances is that they allow us to override onEvent which is 
called whenever a new event is added to the Bloc. Just like with onChange and onTransition, 
onEvent can be overridden locally as well as globally.

### Cubit advantages
One of the biggest advantages of using Cubit is simplicity. When creating a Cubit, we only have 
to define the state as well as the functions which we want to expose to change the state. In 
comparison, when creating a Bloc, we have to define the states, events, and the EventHandler 
implementation. sThis makes Cubit easier to understand and there is less code involved.

### Bloc advantages
One of the biggest advantages of using Bloc is knowing the sequence of state changes as well as 
exactly what triggered those changes. For state that is critical to the functionality of an 
application, it might be very beneficial to use a more event-driven approach in order to capture 
all events in addition to state changes.


## Flutter Bloc Concepts

### Bloc Widgets

* Bloc Builder - handles building the widget in response to new states
```dart
BlocBuilder<BlocA, BlocAState>(
  builder: (context, state) {
    // return widget here based on BlocA's state
  },
);
```
For fine-grained control over when the builder function is called an optional buildWhen can be 
provided. buildWhen takes the previous bloc state and current bloc state and returns a boolean. 
If buildWhen returns true, builder will be called with state and the widget will rebuild. If 
buildWhen returns false, builder will not be called with state and no rebuild will occur.
```dart
BlocBuilder<BlocA, BlocAState>(
  buildWhen: (previousState, state) {
    // return true/false to determine whether or not
    // to rebuild the widget with state
  },
  builder: (context, state) {
    // return widget here based on BlocA's state
  },
);
```

* Bloc Selector - is a Flutter widget which is analogous to BlocBuilder but allows developers to 
  filter updates by selecting a new value based on the current bloc state. Unnecessary builds 
  are prevented if the selected value does not change.
```dart
BlocSelector<BlocA, BlocAState, SelectedState>(
  selector: (state) {
    // return selected state based on the provided state.
  },
  builder: (context, state) {
    // return widget here based on the selected state.
  },
);
```

* Bloc provider - is a Flutter widget which provides a bloc to its children via BlocProvider.
  of<T>(context). It is used as a dependency injection (DI) widget so that a single instance of 
  a bloc can be provided to multiple widgets within a subtree.
  In most cases, BlocProvider should be used to create new blocs which will be made available to 
  the rest of the subtree. In this case, since BlocProvider is responsible for creating the bloc,
  it will automatically handle closing the bloc.
```dart
BlocProvider(
  create: (BuildContext context) => BlocA(),
  child: ChildA(),
);
```

* Multi Bloc Provider - is a Flutter widget that merges multiple BlocProvider widgets into one.
```dart
MultiBlocProvider(
  providers: [
    BlocProvider<BlocA>(
      create: (BuildContext context) => BlocA(),
    ),
    BlocProvider<BlocB>(
      create: (BuildContext context) => BlocB(),
    ),
    BlocProvider<BlocC>(
      create: (BuildContext context) => BlocC(),
    ),
  ],
  child: ChildA(),
);
```

* Bloc listener - is a Flutter widget which takes a BlocWidgetListener and an optional Bloc and 
  invokes the listener in response to state changes in the bloc. It should be used for 
  functionality that needs to occur once per state change such as navigation, showing a SnackBar,
  showing a Dialog, etc…
```dart
BlocListener<BlocA, BlocAState>(
  listener: (context, state) {
    // do stuff here based on BlocA's state
  },
  child: const SizedBox(),
);
```
For fine-grained control over when the listener function is called an optional listenWhen can be 
provided. listenWhen takes the previous bloc state and current bloc state and returns a boolean. 
If listenWhen returns true, listener will be called with state. If listenWhen returns false, 
listener will not be called with state.
```dart
BlocListener<BlocA, BlocAState>(
  listenWhen: (previousState, state) {
    // return true/false to determine whether or not
    // to call listener with state
  },
  listener: (context, state) {
    // do stuff here based on BlocA's state
  },
  child: const SizedBox(),
);
```

* Multi Bloc Listener - is a Flutter widget that merges multiple BlocListener widgets into one.
```dart
MultiBlocListener(
  listeners: [
    BlocListener<BlocA, BlocAState>(
      listener: (context, state) {},
    ),
    BlocListener<BlocB, BlocBState>(
      listener: (context, state) {},
    ),
    BlocListener<BlocC, BlocCState>(
      listener: (context, state) {},
    ),
  ],
  child: ChildA(),
);
```

* Bloc Consumer -  exposes a builder and listener in order to react to new states. BlocConsumer 
  is analogous to a nested BlocListener and BlocBuilder but reduces the amount of boilerplate 
  needed. BlocConsumer should only be used when it is necessary to both rebuild UI and execute 
  other reactions to state changes in the bloc. BlocConsumer takes a required BlocWidgetBuilder 
  and BlocWidgetListener and an optional bloc, BlocBuilderCondition, and BlocListenerCondition.
```dart
BlocConsumer<BlocA, BlocAState>(
  listenWhen: (previous, current) {
    // return true/false to determine whether or not
    // to invoke listener with state
  },
  listener: (context, state) {
    // do stuff here based on BlocA's state
  },
  buildWhen: (previous, current) {
    // return true/false to determine whether or not
    // to rebuild the widget with state
  },
  builder: (context, state) {
    // return widget here based on BlocA's state
  },
);
```

* Repository Provider - is a Flutter widget which provides a repository to its children via 
  RepositoryProvider.of<T>(context). It is used as a dependency injection (DI) widget so that a 
  single instance of a repository can be provided to multiple widgets within a subtree. 
  BlocProvider should be used to provide blocs whereas RepositoryProvider should only be used 
  for repositories.
```dart
RepositoryProvider(
  create: (context) => RepositoryA(),
  child: ChildA(),
); 
```

* Multi Repository Provider - is a Flutter widget that merges multiple RepositoryProvider widgets into one. 
```dart
MultiRepositoryProvider(
  providers: [
    RepositoryProvider<RepositoryA>(
      create: (context) => RepositoryA(),
    ),
    RepositoryProvider<RepositoryB>(
      create: (context) => RepositoryB(),
    ),
    RepositoryProvider<RepositoryC>(
      create: (context) => RepositoryC(),
    ),
  ],
  child: ChildA(),
);
```

What to do and avoid and also more details about above widgets can be found under URL: 
https://bloclibrary.dev/flutter-bloc-concepts/

## Architecture
Using the bloc library allows us to separate our application into three layers:
* Presentation
* Business Logic
* Data
 * * Repository
 * * Data Provider

The data layer’s responsibility is to retrieve/manipulate data from one or more sources.
The data layer can be split into two parts:
* Repository
* Data Provider
This layer is the lowest level of the application and interacts with databases, network requests,
and other asynchronous data sources.

The data provider’s responsibility is to provide raw data. The data provider should be generic 
and versatile. The repository layer is a wrapper around one or more data providers with which 
the Bloc Layer communicates.

The business logic layer’s responsibility is to respond to input from the presentation layer 
with new states. This layer can depend on one or more repositories to retrieve data needed to 
build up the application state.

IMPORTANT: Avoid communication between two Blocs!
Generally, sibling dependencies between two entities in the same architectural layer should be 
avoided at all costs, as it creates tight-coupling which is hard to maintain. Since blocs 
reside in the business logic architectural layer, no bloc should know about any other bloc.
A bloc should only receive information through events and from injected repositories (i.e., 
repositories given to the bloc in its constructor).
If you’re in a situation where a bloc needs to respond to another bloc, you have two other 
options. You can push the problem up a layer (into the presentation layer), or down a layer 
(into the domain layer).

The presentation layer’s responsibility is to figure out how to render itself based on one or 
more bloc states. In addition, it should handle user input and application lifecycle events.

## Modeling State
We have 2 main approaches for modeling state for Bloc:
* Concrete Class and Status Enum
* Sealed Class and Subclasses.

First one is easy to maintain, but it's not type safe. It is best for simple states.
```dart
enum TodoStatus { initial, loading, success, failure }

final class TodoState {
  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const <Todo>[],
    this.exception = null,
  });
  final TodoStatus status;
  final List<Todos> todos;
  final Exception? exception;
}
```

Second is more complex and require a lot of boilerplate code but it's type safe and exhaustive.
This approach works best for well-defined, exclusive states with unique properties. This 
approach provides type safety & exhaustiveness checks and emphasizes safety over conciseness and 
simplicity.
```dart
sealed class WeatherState {
  const WeatherState();
}
final class WeatherInitial extends WeatherState {
  const WeatherInitial();
}
final class WeatherLoadInProgress extends WeatherState {
  const WeatherLoadInProgress();
}
final class WeatherLoadSuccess extends WeatherState {
  const WeatherLoadSuccess({required this.weather});
  final Weather weather;
}
final class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure({required this.exception});
  final Exception exception;
}
```

## Naming Conventions 

### Events
Events should be named in the past tense because events are things that have already occurred 
from the bloc’s perspective.

BlocSubject + Noun (optional) + Verb (event)
Initial load events should follow the convention: BlocSubject + Started

Note: The base event class should be name: BlocSubject + Event.

Good examples:
```dart
sealed class CounterEvent {}
final class CounterStarted extends CounterEvent {}
final class CounterIncrementPressed extends CounterEvent {}
final class CounterDecrementPressed extends CounterEvent {}
final class CounterIncrementRetried extends CounterEvent {}
```

Bad examples:
```dart
sealed class CounterEvent {}
final class Initial extends CounterEvent {}
final class CounterInitialized extends CounterEvent {}
final class Increment extends CounterEvent {}
final class DoIncrement extends CounterEvent {}
final class IncrementCounter extends CounterEvent {}
```

### State
States should be nouns because a state is just a snapshot at a particular point in time. There 
are two common ways to represent state: using subclasses or using a single class.

#### Subclasses
BlocSubject + Verb (action) + State
When representing the state as multiple subclasses State should be one of the following:
Initial | Success | Failure | InProgress

Note: Initial states should follow the convention: BlocSubject + Initial.

Good examples:
```dart
sealed class CounterState {}
final class CounterInitial extends CounterState {}
final class CounterLoadInProgress extends CounterState {}
final class CounterLoadSuccess extends CounterState {}
final class CounterLoadFailure extends CounterState {}
```

Bad examples:
```dart
sealed class CounterState {}
final class Initial extends CounterState {}
final class Loading extends CounterState {}
final class Success extends CounterState {}
final class Succeeded extends CounterState {}
final class Loaded extends CounterState {}
final class Failure extends CounterState {}
final class Failed extends CounterState {}
```

#### Single Class
BlocSubject + State
When representing the state as a single base class an enum named BlocSubject + Status should be 
used to represent the status of the state:
initial | success | failure | loading.

Note: The base state class should always be named: BlocSubject + State.

Good examples:
```dart
enum CounterStatus { initial, loading, success, failure }
final class CounterState {
  const CounterState({this.status = CounterStatus.initial});
  final CounterStatus status;
}
```
