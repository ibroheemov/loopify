import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:dartz/dartz.dart';

class GetChallengesUsecase extends UseCase<List<Challenge>, NoParams> {
  final ChallengeRepository repository;

  GetChallengesUsecase(this.repository);

  @override
  Future<Either<Failure, List<Challenge>>> call(params) async {
    return await repository.getChallenges();
  }
}
