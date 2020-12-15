import 'package:flutter/material.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy, Error }

class BaseController extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
