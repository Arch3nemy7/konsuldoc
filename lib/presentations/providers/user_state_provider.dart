import 'package:konsuldoc/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_provider.g.dart';

@Riverpod(keepAlive: true)
class UserState extends _$UserState {
  @override
  User? build() {
    return null;
  }

  void update(User user) {
    state = user;
  }
}
