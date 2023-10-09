import 'package:finalyear/views/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeletionStatusController extends GetxController {
  final RxBool deletionStatus = false.obs;

  @override
  void onInit() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      startDeletionStatusListener(currentUser.email!);
    }
    super.onInit();
  }

  void startDeletionStatusListener(String? email) async {
    if (email != null) {
      FirebaseFirestore.instance
          .collection('deletionRequests')
          .doc(email)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final status = snapshot.get('status') as bool? ?? false;
          deletionStatus.value = status;

          if (status) {
            // Perform actions for account deletion (e.g., log the user out).

            Get.to(const loginpage());
            print("user has been delted");

            FirebaseAuth.instance.currentUser!.delete();
            Get.snackbar("Message", "Your account has been deleted by admin");
          }
        } else {
          // Handle the case where the document doesn't exist
          print('error accur while deleting');
        }
      });
    }
  }
}
