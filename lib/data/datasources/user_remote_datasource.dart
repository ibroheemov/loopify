// import 'dart:convert';

// import 'package:apexhabit/core/config/constants.dart';
// import 'package:apexhabit/di/sl.dart';
// import 'package:apexhabit/domain/entities/habit.dart';
// import 'package:apexhabit/domain/entities/habit_completed.dart';
// import 'package:apexhabit/firebase_options.dart';
// import 'package:apexhabit/presentation/components/paywall/iap_connection.dart';
// import 'package:apexhabit/presentation/components/paywall/purchasable_product.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:http/http.dart' as http;
// import 'package:isar/isar.dart';

// import 'subscription_local_data_source.dart';

// abstract class UserRemoteDatasource {
//   Future<void> initializeFirebase();
//   Future<void> signout();
//   Future<void> purchaseSubscription(PurchasableProduct product);
//   Future<bool> verifyPurchase(PurchaseDetails purchaseDetails);
//   Future<UserCredential> signInWithGoogle();
//   Future<UserCredential> linkAnonymousToGoogle();
//   Future<void> syncData(String userId);
//   Future<void> getSyncedData(String userId);
// }

// class UserRemoteDatasourceImpl implements UserRemoteDatasource {
//   final iapConnection = IAPConnection.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   SubscriptionLocalDataSource subscriptionLocalDataSource;
//   final Isar isar;

//   UserRemoteDatasourceImpl({
//     required this.subscriptionLocalDataSource,
//     required this.isar,
//   });

//   User? get user => FirebaseAuth.instance.currentUser;

//   @override
//   Future<void> purchaseSubscription(product) async {
//     try {
//       if (user == null) await _loginAnonymously();

//       final purchaseParam =
//           PurchaseParam(productDetails: product.productDetails);
//       await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) async {
//     try {
//       const uri = 'https://${K.serviceAccount}/verifypurchase';
//       const headers = {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };
//       final body = jsonEncode({
//         'source': purchaseDetails.verificationData.source,
//         'productId': purchaseDetails.productID,
//         'verificationData':
//             purchaseDetails.verificationData.serverVerificationData,
//         'userId': user?.uid,
//       });

//       final url = Uri.parse(uri);
//       final response = await http.post(url, body: body, headers: headers);
//       print(response.statusCode);
//       print(response.body);
//       if (response.statusCode == 200) {
//         Map<String, dynamic> purchaseData = jsonDecode(response.body);
//         print("STATUS");
//         print(purchaseData['status']);
//         final expiryDate = DateTime.parse(purchaseData['expiryDate'] + "Z")
//             .toLocal()
//             .toIso8601String();
//         final isSubscribed = subscriptionLocalDataSource
//             .saveSubscriptionLocally(expiryDate, purchaseData['status']);

//         // Mark that purchased content has been delivered to the user.
//         if (purchaseDetails.pendingCompletePurchase) {
//           await iapConnection.completePurchase(purchaseDetails);
//         }

//         return isSubscribed;
//       } else {
//         return Future.value(false);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> _loginAnonymously() async {
//     try {
//       await FirebaseAuth.instance.signInAnonymously();
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<UserCredential> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       return FirebaseAuth.instance.signInWithCredential(credential);
//     } else {
//       throw FirebaseAuthException(
//         code: 'ERROR_ABORTED_BY_USER',
//         message: 'Sign in aborted by user',
//       );
//     }
//   }

//   @override
//   Future<void> initializeFirebase() async {
//     try {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<UserCredential> linkAnonymousToGoogle() async {
//     final user = FirebaseAuth.instance.currentUser;

//     try {
//       // Get Google sign-in credentials
//       UserCredential googleCredential = await signInWithGoogle();

//       // Link the Google credentials to the anonymous account
//       await user!.linkWithCredential(googleCredential.credential!);
//       print("Anonymous account successfully linked with Google account.");
//       return googleCredential;
//     } catch (e) {
//       rethrow;
//       // Handle errors here (e.g., if the Google account is already linked to another account)
//     }
//   }

//   @override
//   Future<void> syncData(String userId) async {
//     try {
//       final allHabits = await isar.habits.filter().categoryIdIsNull().findAll();
//       final allHabitComepletions = await isar.habitCompleteds.where().findAll();

//       List<Map<String, dynamic>> habitsData =
//           allHabits.map((habit) => habit.toMap()).toList();

//       List<Map<String, dynamic>> habitCompletionsData =
//           allHabitComepletions.map((completion) => completion.toMap()).toList();

//       await FirebaseFirestore.instance.collection('users').doc(userId).set(
//           {'habits': habitsData, 'habit_completions': habitCompletionsData});
//     } catch (e) {
//       print('Error syncing all habits: $e');
//     }
//   }

//   @override
//   Future<void> getSyncedData(String userId) async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//       final allHabits = await isar.habits.filter().categoryIdIsNull().findAll();

//       if (snapshot.exists && snapshot.data() != null) {
//         List habitsData = (snapshot.data() as Map<String, dynamic>)['habits'];
//         List habitCompletionsData =
//             (snapshot.data() as Map<String, dynamic>)['habit_completions'];
//         if (habitsData.length < allHabits.length) return;
//         final habits =
//             habitsData.map((habitData) => Habit.fromJson(habitData)).toList();

//         final habitCompletions = habitCompletionsData
//             .map((habitData) => HabitCompleted.fromJson(habitData))
//             .toList();

//         await sl<Isar>().writeTxn(() async {
//           await sl<Isar>().habits.putAll(habits);
//           await sl<Isar>().habitCompleteds.putAll(habitCompletions);
//         });
//       }
//     } catch (e) {
//       print('Error syncing all habits: $e');
//     }
//   }

//   @override
//   Future<void> signout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
