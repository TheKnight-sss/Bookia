import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();

  register() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: confirmpasswordController.text,
    );

    var response = await AuthRepo.register(params);

    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  login() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    var response = await AuthRepo.login(params);
    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
  logout() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.logout();

    if (res != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
