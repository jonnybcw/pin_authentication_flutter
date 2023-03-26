import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pin_authentication_flutter/config/hive_config.dart';
import 'package:pin_authentication_flutter/data/models/field_state.dart';

part 'create_pin_code_state.dart';

class CreatePinCodeCubit extends Cubit<CreatePinCodeState> {
  CreatePinCodeCubit() : super(CreatePinCodeInitial()) {
    emit(_getIdleState());
  }

  int _step = 0;
  final TextEditingController _firstPinController = TextEditingController();
  final TextEditingController _secondPinController = TextEditingController();

  void keyPressed({required String key}) {
    TextEditingController controller = _getCurrentController();
    String text = controller.text;
    if (key == 'backspace') {
      if (text.isNotEmpty) {
        controller.text = text.substring(0, text.length - 1);
      }
      emit(_getIdleState());
    } else {
      controller.text = text + key;
      if (controller.text.length == 4) {
        if (_step == 0) {
          _step = 1;
          emit(_getIdleState());
        } else {
          if (_firstPinController.text == _secondPinController.text) {
            _savePin(pin: _firstPinController.text);
            emit(_getIdleState(
              message: 'Your PIN has been set up successfully!',
            ));
          } else {
            _step = 0;
            _firstPinController.clear();
            _secondPinController.clear();
            emit(_getIdleState(
              message: 'Your PIN does not match, please try again.',
            ));
          }
        }
      } else {
        emit(_getIdleState());
      }
    }
  }

  Future<void> _savePin({required String pin}) async {
    await HiveConfig.saveUserPin(pin);
  }

  TextEditingController _getCurrentController() {
    if (_step == 0) {
      return _firstPinController;
    } else {
      return _secondPinController;
    }
  }

  CreatePinCodeIdle _getIdleState({String? message}) {
    return CreatePinCodeIdle(
      step: _step,
      currentFieldState: _getCurrentFieldState(),
      message: message,
    );
  }

  FieldState _getCurrentFieldState() {
    TextEditingController controller = _getCurrentController();
    return FieldState(
      controller: controller,
      text: controller.text,
    );
  }
}
