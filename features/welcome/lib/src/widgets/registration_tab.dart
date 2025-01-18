import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
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
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        return MultiBlocListener(
          listeners: <SingleChildWidget>[
            BlocListener<SignUpCubit, SignUpState>(
              listenWhen: (SignUpState previous, SignUpState current) =>
                  current is SignUpSuccess,
              listener: (BuildContext context, SignUpState state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Success!')),
                );
              },
            ),
            BlocListener<SignUpCubit, SignUpState>(
              listenWhen: (SignUpState previous, SignUpState current) =>
                  current is SignUpError,
              listener: (BuildContext context, SignUpState state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error}')),
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FormTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    style: const TextStyle(color: Colors.black),
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FormTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: context.watch<SignUpCubit>().obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? val) {
                      setState(() {
                        containsUpperCase = val!.contains(RegExp(r'[A-Z]'));
                        containsLowerCase = val.contains(RegExp(r'[a-z]'));
                        containsNumber = val.contains(RegExp(r'[0-9]'));
                        containsSpecialChar = val.contains(RegExp(
                            r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'));
                        contains8Length = val.length >= 8;
                      });
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<SignUpCubit>().togglePasswordVisibility();
                      },
                      icon: Icon(
                        context.watch<SignUpCubit>().obscurePassword
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
                              color: containsUpperCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface),
                        ),
                        Text(
                          '⚈  1 lowercase',
                          style: TextStyle(
                              color: containsLowerCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface),
                        ),
                        Text(
                          '⚈  1 number',
                          style: TextStyle(
                              color: containsNumber
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '⚈  1 special character',
                          style: TextStyle(
                              color: containsSpecialChar
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface),
                        ),
                        Text(
                          '⚈  8 minimum characters',
                          style: TextStyle(
                              color: contains8Length
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FormTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    style: const TextStyle(color: Colors.black),
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
                if (state is SignUpProcess)
                  const CircularProgressIndicator()
                else
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final MyUser user = MyUser.empty.copyWith(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                          );
                          context
                              .read<SignUpCubit>()
                              .signUp(user, passwordController.text.trim());
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
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
}
