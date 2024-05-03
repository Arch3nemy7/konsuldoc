import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/domain/models/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
