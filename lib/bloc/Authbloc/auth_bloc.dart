import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          final user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          CollectionReference users =
              FirebaseFirestore.instance.collection("Users");
          users
              .doc(user.user!.uid)
              .set(
                {
                  'username': event.Username,
                  'email': event.email,
                  'password': event.password,
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
      } else if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(MassageError: "user-not-found"));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(MassageError: 'wrong-password'));
          }
        } on Exception {
          emit(LoginFailure(MassageError: "something went wrong"));
        }
      }
    });
  }
}
