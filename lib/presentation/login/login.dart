import 'package:complete_advanced_project/app/di.dart';
import 'package:complete_advanced_project/presentation/login/login_viewModel.dart';
import 'package:complete_advanced_project/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_project/presentation/resources/color_manager.dart';
import 'package:complete_advanced_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind(){
    _loginViewModel.start();
    _userNameController.addListener(() => _loginViewModel.setUserName(_userNameController.text));
    _userNameController.addListener(() => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget(){
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28,right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsUserNameValid,
                    builder: (context,snapshot){
                      return TextFormField(
                       keyboardType: TextInputType.emailAddress,
                       controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: AppString.userName,
                          label: const Text(AppString.userName),
                          errorText: (snapshot.data ?? true) ? null : AppString.userNameError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28,right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsPasswordValid,
                    builder: (context,snapshot){
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppString.password,
                          label: const Text(AppString.password),
                          errorText: (snapshot.data ?? true) ? null : AppString.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(padding: const EdgeInsets.only(
                    left: AppPadding.p28,right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsAllInputsValid,
                    builder : (context,snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? (){
                              _loginViewModel.login();
                            } : null,
                            child: const Text(
                              AppString.login
                            ),
                        ),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p8,left: AppPadding.p28,right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, Routes.forgetPasswordRoute);
                          },
                          child: Text(
                            AppString.forgetPassword,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppString.register,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
