import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
AuthController authController(AuthControllerRef ref) {
  return AuthController(repository: ref.watch(authRepositoryProvider));
}

class AuthController {
  final AuthRepository _repository;

  AuthController({required AuthRepository repository})
      : _repository = repository;

  void signIn({
    required String email,
    required String password,
  }) async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.signIn(
      email: email,
      password: password,
    ));
    cancel();

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.signUp(
      name: name,
      email: email,
      password: password,
    ));
    cancel();

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }

  void signOut() async {
    final cancel = BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
    final res = await handleError(_repository.signOut());
    cancel();

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }
}
