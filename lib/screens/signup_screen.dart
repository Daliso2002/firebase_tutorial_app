import 'package:email_validator/email_validator.dart';
import 'package:firebase_tutorial_app/screens/home_page.dart';
import 'package:firebase_tutorial_app/services/authntication_sevices.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<String> _genderList = ["Female", "Male"];
  String? _selectedGender;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  _signUp() async {
    setState(() {
      _isLoading = true;
    });
    var result = await AuthServices().signUp(
        email: _emailController.text,
        password: _passwordController.text,
        gender: _selectedGender!,
        age: int.parse(_ageController.text),
        username: _usernameController.text);
    setState(() {
      _isLoading = false;
    });
    if (result != "Success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyHomePage(title: "HomePage"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !EmailValidator.validate(value.trim())) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                        prefixIcon: Icon(Icons.child_care),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null) {
                            return "Select your gender";
                          } else {
                            return null;
                          }
                        },
                        items: _genderList
                            .map((String gender) => DropdownMenuItem(
                                  child: Text(gender),
                                  value: gender,
                                ))
                            .toList(),
                        onChanged: (gender) {
                          setState(() {
                            _selectedGender = gender;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                          }
                        },
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(' Sign Up ')),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
