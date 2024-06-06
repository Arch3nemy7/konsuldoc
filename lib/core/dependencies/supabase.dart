import 'package:konsuldoc/core/constants/supabase_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase.g.dart';

@Riverpod(keepAlive: true)
Supabase supabase(SupabaseRef ref) {
  return Supabase.instance;
}

@Riverpod(keepAlive: true)
SupabaseClient supabaseAdmin(SupabaseAdminRef ref) {
  return SupabaseClient(
    SupabaseConstants.url,
    SupabaseConstants.serviceRoleKey,
  );
}
