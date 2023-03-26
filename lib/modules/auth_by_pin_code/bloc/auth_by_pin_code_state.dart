part of 'auth_by_pin_code_cubit.dart';

abstract class AuthByPinCodeState extends Equatable {
  const AuthByPinCodeState();

  @override
  List<Object?> get props => [];
}

class CreatePinCodeInitial extends AuthByPinCodeState {}

class PinNotCreated extends AuthByPinCodeState {}

class CreatePinCodeIdle extends AuthByPinCodeState {
  const CreatePinCodeIdle({
    required this.pinFieldState,
    required this.message,
  });

  final FieldState pinFieldState;
  final String? message;

  @override
  List<Object?> get props => [
        pinFieldState,
        message,
      ];
}
