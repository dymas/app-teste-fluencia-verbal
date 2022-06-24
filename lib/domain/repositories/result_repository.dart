import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/result.dart';

abstract class ResultRepository {
  Future<Either<Failure, void>> saveNewResult(Result result);
}
