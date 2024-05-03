import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/data/models/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
