import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../bloc/sign_in/sign_in_cubit.dart';

class AuthenticationTab extends StatefulWidget {
  final bool signInRequired;
  final String? errorMsg;

  const AuthenticationTab({
    super.key,
    this.signInRequired = false,
    this.errorMsg,
  });

  @override
  State<AuthenticationTab> createState() => _AuthenticationTabState();
}

class _AuthenticationTabState extends State<AuthenticationTab> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
        builder: (BuildContext context, SignInState state) {
      return MultiBlocListener(
        listeners: <SingleChildWidget>[
          BlocListener<SignInCubit, SignInState>(
            listenWhen: (SignInState previous, SignInState current) =>
                current is SignInSuccess,
            listener: (BuildContext context, SignInState state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success!')),
              );
            },
          ),
          BlocListener<SignInCubit, SignInState>(
            listenWhen: (SignInState previous, SignInState current) =>
                current is SignInError,
            listener: (BuildContext context, SignInState state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error')),
              );
            },
          )
        ],
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  errorMsg: widget.errorMsg,
                  style: const TextStyle(color: Colors.black),
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: FormTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: context.watch<SignInCubit>().obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  style: const TextStyle(color: Colors.black),
                  errorMsg: widget.errorMsg,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)%\-(_+=;:,.<>/?"[\{\]}\\|^]).{8,}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SignInCubit>().togglePasswordVisibility();
                    },
                    icon: Icon(
                      context.watch<SignInCubit>().obscurePassword
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (state is SignInProcess)
                const CircularProgressIndicator()
              else
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInCubit>().signIn(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                    }
                  },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const Spacer(flex: 15),
            ],
          ),
        ),
      );
    });
  }
}
