import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/signup_screen.dart';
import 'package:note_app/screen/auth/validaror_auth.dart';
import 'package:note_app/screen/home_screen.dart';
import 'package:note_app/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(child: Text(' Login')),
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => ValidarorsAuth.emailValidator(value!),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      ValidarorsAuth.passwordValidator(value!),
                ),
                const SizedBox(
                  height: 25,
                ),
                loading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .75,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? result = await AuthService.login(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                              setState(() {
                                loading = false;
                              });
                              if (result != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  child: const Text('Don\'t have an account? Register Here'),
                )
              ],
            )),
      ),
    );
  }
}
