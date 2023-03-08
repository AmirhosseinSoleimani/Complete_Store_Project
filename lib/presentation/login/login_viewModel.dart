import 'dart:async';
import 'package:complete_advanced_project/domain/useCase/login_useCase.dart';
import 'package:complete_advanced_project/presentation/base/base_viewModel.dart';
import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutputs{


  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject("","");
  final LoginUseCase? _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // Input
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async{
    (await _loginUseCase?.execute(LoginUseCaseInput(
        loginObject.userName, loginObject.password)))?.fold((
        failure) => {
          // left -> failure
      print(failure.message)
    }, (data) => {
          // right -> success(data)
          print(data.customer?.name)
    });
  }


  @override
  setPassword(String password) {
    inputPassword.add(password);
    // data class operation same as kotlin
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    // data class operation same as kotlin
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  // Output
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUseNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());


  // Private Functions

  _validate(){
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUseNameValid(String userName){
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid(){
    return _isPasswordValid(loginObject.password) && _isUseNameValid(loginObject.userName);
  }


}

abstract class LoginViewModelInput{
  // three functions
  setUserName(String userName);
  setPassword(String password);
  login();

  // two sinks
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs{
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}