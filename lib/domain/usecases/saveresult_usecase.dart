import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/result_repository.dart';
import '../entities/result.dart';

class SaveResultUseCase {
  final ResultRepository repository;

  SaveResultUseCase(this.repository);

  Future<Either<Failure, void>> sendResultToRepository(Result result) {
    return repository.saveNewResult(result);
  }
}
