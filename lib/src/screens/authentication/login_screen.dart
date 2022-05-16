import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jb_notify/src/cubit/firebase_sign_in_cubit.dart';
import 'package:jb_notify/src/repository/firebase_authentication.dart';
import 'package:jb_notify/src/screens/navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseSignInCubit>(
      create: (context) {
        return FirebaseSignInCubit(
          authServices: AuthenticationServices(),
        );
      },
      child: const LoginScreenView(),
    );
  }
}

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({Key? key}) : super(key: key);

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hiddenPassword = true;

  BuildContext? loadingContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Faculty Login',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    Image.asset('lib/assets/images/login.png'),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter correct email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'E-Mail',
                          hintText: 'Enter your E-mail ID',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: hiddenPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        prefixIcon: const Icon(Icons.key_rounded),
                        suffixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              child: SvgPicture.asset(hiddenPassword
                                  ? "lib/assets/icons/not_visible_icon.svg"
                                  : "lib/assets/icons/visible_icon.svg")),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              BlocConsumer<FirebaseSignInCubit, FirebaseSignInState>(
                listener: (context, state) {
                  if (loadingContext != null) {
                    Navigator.pop(loadingContext!);
                  }
                  if (state is FirebaseSignInLoading) {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          loadingContext = ctx;
                          return const CircularProgressIndicator();
                        }).then((value) {
                      loadingContext = null;
                    });
                  }
                  if (state is FirebaseSignInSuccess) {
                    final String? value = state.user?.uid;
                    print(value);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const NavigationScreen()),
                        (route) => false);
                  } else if (state is FirebaseSignInFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Unable to login! Please try again !'),
                      ),
                    );
                  } else if (state is FirebaseSignInError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Some error has occurred!. Try again later.'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<FirebaseSignInCubit>().loginWithEmailAndPass(
                              email: emailController.value.text,
                              password: passwordController.value.text,
                            );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, letterSpacing: 1.5),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
