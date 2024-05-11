import 'package:bot_toast/bot_toast.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/domain/repositories/auth_repository.dart';

class AuthController {
  final AuthRepository _repository;

  AuthController({required AuthRepository repository})
      : _repository = repository;

  Future<bool> addUser({
    required String email,
    required String password,
    required Role role,
  }) async {
    final res = await handleError(_repository.addUser(
      email: email,
      password: password,
      role: role,
    ));

    return res.fold(
      (l) {
        BotToast.showText(text: 'Gagal menambahkan ${role.name}');
        return false;
      },
      (r) {
        BotToast.showText(text: 'Berhasil menambahkan ${role.name}');
        return true;
      },
    );
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    final res = await handleError(_repository.signIn(
      email: email,
      password: password,
    ));

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await handleError(_repository.signUp(
      name: name,
      email: email,
      password: password,
    ));

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }

  void signOut() async {
    final res = await handleError(_repository.signOut());

    res.mapLeft((error) => BotToast.showText(text: error.message));
  }
}
