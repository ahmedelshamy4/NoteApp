import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/validaror_auth.dart';
import 'package:note_app/services/auth_services.dart';

import '../home_screen.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: Text(' Sign Up')),
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
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => ValidarorsAuth.passwordValidator(value!),
              ),
              const SizedBox(
                height: 15,
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
                            User? result = await AuthService.signUp(context,
                                emailController.text, passwordController.text);

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
                                loading = true;
                              });
                            }
                          }
                        },
                        child: const Text('SignUp'),
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
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: const Text('Already have an account? Login Here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
