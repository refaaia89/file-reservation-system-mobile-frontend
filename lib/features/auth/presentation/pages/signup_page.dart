import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/core/feature/presentation/widgets/custom_button.dart';
import 'package:internet_application/core/helper/form_validation.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_application/features/auth/presentation/mixin/signup_mixin.dart';
import 'package:internet_application/features/auth/presentation/pages/custom_auth_page.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';

import '../widgets/widget_auth.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget with SingUpMixin {
  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formKey, child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomAuthPage(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: context.height - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _header(),
              _inputField(context),
              btnHintToSignUpOrLogin(
                  context: context,
                  descriptionBtn: "Already have an account?",
                  nameBtn: "Login",
                  function: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Column _inputField(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTextFormField(
            controller: userNameController,
            validator: (value) => FormValidation.notEmpty(value!),
            hintText: "Username",
            prefixIcon: const Icon(Icons.person),
            obscureText: false,
            context: context),
        const SizedBox(height: 20),
        buildTextFormField(
          controller: emailController,
          validator: (value) => FormValidation.emailValidation(value!),
          hintText: "Email",
          prefixIcon: const Icon(Icons.email),
          obscureText: false,
          context: context,
        ),
        const SizedBox(height: 20),
        buildTextFormField(
          controller: passwordController,
          validator: (value) => FormValidation.passwordValidation(value!),
          hintText: "Password",
          prefixIcon: const Icon(Icons.password),
          obscureText: true,
          context: context,
        ),
        const SizedBox(height: 20),
        buildTextFormField(
          controller: confirmPasswordController,
          validator: (value) => FormValidation.confirmPasswordValidation(value!, passwordController.value.text),
          hintText: "Confirm Password",
          prefixIcon: const Icon(Icons.password),
          obscureText: true,
          context: context,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: context.width / 4,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SuccessSignUpState) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              }
              if (state is ErrorSignUpState) {
                showError(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is LoadingSignUpState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomButton(
                  formKey: formKey,
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                      authEntity: AuthEntity(
                        userName: userNameController.value.text,
                        email: emailController.value.text,
                        password: passwordController.value.text,
                      ),
                    ));
                  },
                  text: "Sign up");
            },
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60.0),
        const Text(
          "Sign up",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Create your account",
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        )
      ],
    );
  }
}
