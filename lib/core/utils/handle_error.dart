import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/core/entities/failure.dart';

Future<Either<Failure, T>> handleError<T>(Future<T> func) async {
  try {
    return right(await func);
  } catch (e) {
    return left(Failure(e.toString()));
  }
}
