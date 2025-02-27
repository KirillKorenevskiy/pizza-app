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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return BlocBuilder<SignInCubit, SignInState>(
      builder: (BuildContext context, SignInState state) {
        return MultiBlocListener(
          listeners: <SingleChildWidget>[
            BlocListener<SignInCubit, SignInState>(
              listenWhen: (SignInState previous, SignInState current) =>
                  previous.successMessage == null &&
                  current.successMessage != null,
              listener: (BuildContext context, SignInState state) {
                final String? successMessage = state.successMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      successMessage ?? context.locale.success,
                    ),
                  ),
                );
              },
            ),
            BlocListener<SignInCubit, SignInState>(
              listenWhen: (SignInState previous, SignInState current) =>
                  previous.errorMessage == null && current.errorMessage != null,
              listener: (BuildContext context, SignInState state) {
                final String? errorMessage = state.errorMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      errorMessage ?? context.locale.errorHasOccurred,
                    ),
                  ),
                );
              },
            ),
          ],
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: FormTextField(
                    controller: _emailController,
                    hintText: context.locale.email,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    errorMsg: widget.errorMsg,
                    style: TextStyle(color: colors.black),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return context.locale.philInField;
                      } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return context.locale
                            .enterValidField(context.locale.email);
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: FormTextField(
                    controller: _passwordController,
                    hintText: context.locale.password,
                    obscureText: state.obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    style: TextStyle(color: colors.black),
                    errorMsg: widget.errorMsg,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return context.locale.philInField;
                      } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~`)%\-(_+=;:,.<>/?"[{\]}\\|^]).{8,}$',
                      ).hasMatch(val)) {
                        return context.locale.enterValidField('password');
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<SignInCubit>().togglePasswordVisibility();
                      },
                      icon: Icon(
                        state.obscurePassword
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInCubit>().signIn(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                      }
                    },
                    style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: colors.primaryBg,
                      foregroundColor: colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5,
                      ),
                      child: Text(
                        context.locale.signIn,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.white,
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
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
