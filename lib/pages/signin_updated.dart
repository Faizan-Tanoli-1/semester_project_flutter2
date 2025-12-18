import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sem_project/pages/home.dart';
import 'package:sem_project/pages/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = false;

  // Login Function
  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      // TODO: Navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("images/login.png", fit: BoxFit.cover),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    // Title
                    const Text(
                      "Login to\nAccount",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email
                    _label("Email"),
                    _inputField(
                      hint: "Enter Email",
                      icon: Icons.email,
                      controller: emailController,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    _label("Password"),
                    _inputField(
                      hint: "Enter Password",
                      icon: Icons.lock,
                      isPassword: !showPassword,
                      controller: passwordController,
                      showPasswordToggle: true,
                      onPasswordToggle: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      isPasswordVisible: showPassword,
                    ),

                    const SizedBox(height: 50),

                    // Next Button Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: login,
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                              color: Color(0xff6d2e46),
                              shape: BoxShape.circle,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),

                    // Signup Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              color: Color(0xff6d2e46),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Label Widget
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _inputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required TextEditingController controller,
    bool showPasswordToggle = false,
    VoidCallback? onPasswordToggle,
    bool isPasswordVisible = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xff694879)),
          suffixIcon: showPasswordToggle
              ? GestureDetector(
                  onTap: onPasswordToggle,
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xff694879),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}
