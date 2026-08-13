import 'main_dev.dart' as dev;

/// Default entrypoint — delegates to the dev flavor so plain `flutter run`
/// (no `-t` target) still works. Real builds should target `main_dev.dart`
/// or `main_prod.dart` explicitly with the matching `--dart-define-from-file`.
void main() => dev.main();
