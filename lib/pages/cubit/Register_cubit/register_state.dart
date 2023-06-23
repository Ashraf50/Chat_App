part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

// ignore: must_be_immutable
class RegisterFailure extends RegisterState {
  String MassageError;
  RegisterFailure({required this.MassageError});
}
