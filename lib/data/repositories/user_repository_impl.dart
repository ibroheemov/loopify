// import 'package:apexhabit/core/error/failures.dart';
// import 'package:apexhabit/data/datasources/user_remote_datasource.dart';
// import 'package:apexhabit/domain/repositories/user_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDatasource userRemoteDataSource;

//   UserRepositoryImpl({required this.userRemoteDataSource});

//   @override
//   Future<Either<Failure, void>> purchaseSubscription(product) async {
//     try {
//       await userRemoteDataSource.purchaseSubscription(product);
//       return Right(null);
//     } catch (e) {
//       return Left(PurchaseSubscriptionFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, UserCredential>> signInWithGoogle(
//       linkAnonymousToGoogle) async {
//     try {
//       late UserCredential credential;
//       if (linkAnonymousToGoogle) {
//         credential = await userRemoteDataSource.linkAnonymousToGoogle();
//       } else {
//         credential = await userRemoteDataSource.signInWithGoogle();
//       }
//       print(credential.user);
//       return Right(credential);
//     } catch (e) {
//       return Left(SigninWithGoogleFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> syncedData(userId) async {
//     try {
//       await userRemoteDataSource.syncData(userId);
//       return Right(null);
//     } catch (e) {
//       return Left(SyncDataFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> getSyncedData(userId) async {
//     try {
//       await userRemoteDataSource.getSyncedData(userId);
//       return Right(null);
//     } catch (e) {
//       return Left(SyncDataFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> verifypurchase(purchaseDetails) async {
//     try {
//       final isSubscribed =
//           await userRemoteDataSource.verifyPurchase(purchaseDetails);
//       return Right(isSubscribed);
//     } catch (e) {
//       return Left(VerifyPurchaseFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> initializeFirebase() async {
//     try {
//       await userRemoteDataSource.initializeFirebase();

//       return Right(null);
//     } catch (e) {
//       return Left(VerifyPurchaseFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> signout() async {
//     try {
//       await userRemoteDataSource.signout();

//       return Right(null);
//     } catch (e) {
//       return Left(VerifyPurchaseFailure(e.toString()));
//     }
//   }
// }
