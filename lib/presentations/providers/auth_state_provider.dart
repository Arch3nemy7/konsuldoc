import 'dart:async';

import 'package:konsuldoc/core/dependencies/supabase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

part 'auth_state_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  late final StreamSubscription<sp.AuthState> _subscription;
  sp.SupabaseClient get _supabase => ref.read(supabaseProvider).client;

  @override
  sp.User? build() {
    _initListener();
    _dispose();

    return _supabase.auth.currentUser;
  }

  _initListener() {
    _subscription = _supabase.auth.onAuthStateChange.listen((data) {
      state = data.session?.user;
    });
  }

  _dispose() {
    ref.onDispose(_subscription.cancel);
  }
}
