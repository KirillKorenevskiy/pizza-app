import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../bloc/sign_up/sign_up_cubit.dart';

class RegistrationTab extends StatefulWidget {
  const RegistrationTab({super.key});

  @override
  State<RegistrationTab> createState() => _RegistrationTabState();
}

class _RegistrationTabState extends State<RegistrationTab> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final AppColors colors = AppColors.of(context);

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        return MultiBlocListener(
          listeners: <SingleChildWidget>[
            BlocListener<SignUpCubit, SignUpState>(
              listenWhen: (SignUpState previous, SignUpState current) =>
                  previous.successMessage == null &&
                  current.successMessage != null,
              listener: (BuildContext context, SignUpState state) {
                final String? successMessage = state.successMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(successMessage ?? 'success!!!')),
                );
              },
            ),
            BlocListener<SignUpCubit, SignUpState>(
              listenWhen: (SignUpState previous, SignUpState current) =>
                  previous.errorMessage == null && current.errorMessage != null,
              listener: (BuildContext context, SignUpState state) {
                final String? errorMessage = state.errorMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage ?? 'error(')),
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
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    style: TextStyle(color: colors.black),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid email';
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
                    hintText: 'Password',
                    obscureText: state.obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    style: TextStyle(color: colors.black),
                    onChanged: (String val) {
                      context.read<SignUpCubit>().updatePasswordValidation(val);
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<SignUpCubit>().togglePasswordVisibility();
                      },
                      icon: Icon(
                        state.obscurePassword
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                      ),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '⚈  1 uppercase',
                          style: TextStyle(
                            color: state.containsUpperCase
                                ? colors.green
                                : colors.black,
                          ),
                        ),
                        Text(
                          '⚈  1 lowercase',
                          style: TextStyle(
                            color: state.containsLowerCase
                                ? colors.green
                                : colors.black,
                          ),
                        ),
                        Text(
                          '⚈  1 number',
                          style: TextStyle(
                            color: state.containsNumber
                                ? colors.green
                                : colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '⚈  1 special character',
                          style: TextStyle(
                            color: state.containsSpecialChar
                                ? colors.green
                                : colors.black,
                          ),
                        ),
                        Text(
                          '⚈  8 minimum characters',
                          style: TextStyle(
                            color: state.containsMinLength
                                ? colors.green
                                : colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: FormTextField(
                    controller: _nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    style: TextStyle(color: colors.black),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (val.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  SizedBox(
                    width: screenSize.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String name = _nameController.text.trim();
                          final String email = _emailController.text.trim();
                          final String password =
                              _passwordController.text.trim();
                          context
                              .read<SignUpCubit>()
                              .signUp(email, name, password);
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
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                const Spacer(flex: 7)
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
    _nameController.dispose();
    super.dispose();
  }
}
