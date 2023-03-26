part of 'create_pin_code_cubit.dart';

abstract class CreatePinCodeState extends Equatable {
  const CreatePinCodeState();

  @override
  List<Object?> get props => [];
}

class CreatePinCodeInitial extends CreatePinCodeState {}

class CreatePinCodeIdle extends CreatePinCodeState {
  const CreatePinCodeIdle({
    required this.step,
    required this.currentFieldState,
    required this.message,
  });

  final int step;
  final FieldState currentFieldState;
  final String? message;

  @override
  List<Object?> get props => [
        step,
        currentFieldState,
        message,
      ];
}
