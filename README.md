# Flutter Knowledge Base

A Flutter project to collect useful knowledge in one place to use it in different projects.

## Dependencies and useful packages/plugins

In pubspec.yaml file dependencies were written down and categorized (Firebase, Networking, 
Storage, Utils, State Management). All package data contains: Name, Short description and 
version for moment of creating this repository.

### Note
To run 
```bash
flutter pub get 
```
or
```bash
dart run build_runner build
```
below dependencies in pubspec.yaml file need to be commented/removed.

```yaml
  ## GraphQL Flutter - GraphQL Client for dart.
  graphql: ^5.1.3
  graphql_flutter: ^5.1.2
```

and
```yaml
  ## Isar - Fast, easy to use and fully async NoSQL database for Flutter.
  isar: ^3.1.0+1
  # isar_flutter_libs: ^3.1.0+1
  ### For dev dependencies:
  isar_generator: ^3.1.0+1
  build_runner: any
```
