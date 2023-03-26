import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pin_authentication_flutter/config/hive_config.dart';
import 'package:pin_authentication_flutter/data/models/field_state.dart';

part 'auth_by_pin_code_state.dart';

class AuthByPinCodeCubit extends Cubit<AuthByPinCodeState> {
  AuthByPinCodeCubit() : super(CreatePinCodeInitial()) {
    HiveConfig.getUserPin().then((value) {
      if (value == null) {
        emit(PinNotCreated());
      } else {
        emit(_getIdleState());
      }
    });
  }

  final TextEditingController _pinController = TextEditingController();

  void keyPressed({required String key}) {
    String text = _pinController.text;
    if (key == 'backspace') {
      if (text.isNotEmpty) {
        _pinController.text = text.substring(0, text.length - 1);
      }
      emit(_getIdleState());
    } else {
      _pinController.text = text + key;
      if (_pinController.text.length == 4) {
        _checkPin(enteredPin: _pinController.text);
      } else {
        emit(_getIdleState());
      }
    }
  }

  Future<void> _checkPin({required String enteredPin}) async {
    String? pin = await HiveConfig.getUserPin();
    _pinController.clear();
    if (enteredPin == pin) {
      emit(_getIdleState(
        message: 'Authentication success',
      ));
    } else {
      emit(_getIdleState(
        message: 'Authentication failed',
      ));
    }
  }

  CreatePinCodeIdle _getIdleState({String? message}) {
    return CreatePinCodeIdle(
      pinFieldState: _getPinFieldState(),
      message: message,
    );
  }

  FieldState _getPinFieldState() {
    return FieldState(
      controller: _pinController,
      text: _pinController.text,
    );
  }
}
