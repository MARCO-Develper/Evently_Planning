import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/task_model.dart';
import '../models/userModel.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addEvent(TaskModel model) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Future<void> addUser(UserModel model) {
    var collection = getUserCollection();
    var docRef = collection.doc(model.id);
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> getEvents(String categoryName) {
    var collection = getTasksCollection();
    if (categoryName == "All") {
      return collection
          .orderBy(
            "date",
          )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    } else {
      return collection
          .orderBy(
            "date",
          )
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("category", isEqualTo: categoryName)
          .where("isFavorite", isEqualTo: true)
          .snapshots();
    }
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    var collection = getTasksCollection();
    return collection
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFavorite", isEqualTo: true)
        .orderBy("date")
        .snapshots();
  }

  // static Future<UserModel?> readUserData(String uid) async {
  //   DocumentSnapshot<Map<String, dynamic>> doc =
  //       await FirebaseFirestore.instance.collection("Users").doc(uid).get();
  //
  //   if (!doc.exists || doc.data() == null) return null;
  //
  //   return UserModel.fromJson(doc.data()!);
  // }

  static Future<UserModel?> readUserData(String id) async {
    var collection = getUserCollection();
    DocumentSnapshot<UserModel> snapShot = await collection.doc(id).get();
    return snapShot.data();
  }

  static Future<void> toggleFavorite(TaskModel task) {
    task.isFavorite = !task.isFavorite;
    return updateTask(task);
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();
    return collection.doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) {
    var collection = getTasksCollection();
    return collection.doc(model.id).update(model.toJson());
  }

  static Future<void> createUser(String email, String password, String name,
      Function onSuccess, Function onError, Function onLoading) async {
    try {
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // تأكد من حفظ الاسم بشكل صحيح
      UserModel model = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name, // هذا هو الجزء المهم
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await addUser(model);

      credential.user!.sendEmailVerification();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);

        print('The account already exists for that email.');
      }
    } catch (e) {
      onError("Something went wrong");

      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError, Function onLoading) async {
    try {
      onLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user!.emailVerified) {
      onSuccess();
      // } else {
      //   onError("Email is Not verified , please Check your mail and verify");
      // }
    } on FirebaseAuthException {
      onError("Email or password is not valid");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> logOUt() {
    return FirebaseAuth.instance.signOut();
  }
}
