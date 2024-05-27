import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/core/entities/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<Either<Failure, T>> handleError<T>(Future<T> func) async {
  try {
    return right(await func);
  } on AuthException catch (e) {
    return left(Failure(e.message));
  } catch (e) {
    return left(Failure(e.toString()));
  }
}
