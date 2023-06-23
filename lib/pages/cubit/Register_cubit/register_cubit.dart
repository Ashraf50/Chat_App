import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  SignUp(
      {required String userName,
      required String email,
      required String password}) async {
    emit(RegisterLoading());
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection("Users");
      users
          .doc(user.user!.uid)
          .set(
            {
              'username': userName,
              'email': email,
              'password': password,
            },
          )
          .then(
            (value) => print("User Added"),
          )
          .catchError((error) => print("Failed to add user: $error"));
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(MassageError: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(MassageError: 'email-already-in-use'));
      }
    } on Exception {
      emit(RegisterFailure(MassageError: "something went wrong"));
    }
  }
}
