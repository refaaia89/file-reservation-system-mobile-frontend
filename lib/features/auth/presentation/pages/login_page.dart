import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/core/feature/presentation/widgets/custom_button.dart';
import 'package:internet_application/core/helper/form_validation.dart';
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_application/features/auth/presentation/mixin/login_mixin.dart';
import 'package:internet_application/features/auth/presentation/pages/custom_auth_page.dart';
import 'package:internet_application/features/auth/presentation/pages/signup_page.dart';
import 'package:internet_application/features/user/presentation/pages/home_page.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';

import '../widgets/widget_auth.dart';

class LoginPage extends StatelessWidget with LoginMixin {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formKey, child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomAuthPage(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _header(context),
        _inputField(context),
        SizedBox(
            width: context.width / 4,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (_, state) {
                if (state is SuccessLoginState) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
                }
                if (state is ErrorLoginState) {
                  showError(context, state.message);
                }
              },
              builder: (_, state) {
                if (state is LoadingLoginState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                    formKey: formKey,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: emailController.value.text, password: passwordController.value.text));
                    },
                    text: "Login");
              },
            )),
        btnHintToSignUpOrLogin(
            context: context,
            descriptionBtn: "Don't have an account? ",
            nameBtn: "Sign Up",
            function: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
            }),
      ],
    ));
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTextFormField(
              controller: emailController,
              validator: (value) => FormValidation.emailValidation(value!),
              hintText: "Email",
              prefixIcon: const Icon(Icons.email),
              obscureText: false,
              context: context),
          const SizedBox(height: 20),
          buildTextFormField(
              controller: passwordController,
              validator: (value) => FormValidation.passwordValidation(value!),
              hintText: "Password",
              prefixIcon: const Icon(Icons.password),
              obscureText: true,
              context: context),
        ],
      ),
    );
  }
}
