import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:sem_project/pages/home.dart';
import 'package:sem_project/pages/signin.dart';
import 'package:sem_project/services/database.dart';
// import 'package:sem_project/services/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // Registration function
  registration() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Generate random user Id
      String userId = randomAlphaNumeric(10);

      // Prepare user info map
      Map<String, dynamic> userInfoMap = {
        "Name": name,
        "Email": email,
        "Id": userId,
      };

      // Save to Firestore
      await DatabaseMethods().addUserInfo(userInfoMap, userId);

      // Save locally
      // await SharedpreferenceHelper().saveUserId(userId);
      // await SharedpreferenceHelper().saveUserName(name);
      // await SharedpreferenceHelper().saveUserEmail(email);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Account Created Successfully")));

      // Navigate to SignIn Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'email-already-in-use') {
        message = "This email is already registered";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      } else {
        message = "Error: ${e.message}";
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
            child: Image.asset("images/signup.png", fit: BoxFit.cover),
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
                      "Create\nAccount!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Name
                    _label("Name"),
                    _inputField(
                      hint: "Enter Name",
                      icon: Icons.person,
                      controller: nameController,
                    ),

                    const SizedBox(height: 20),

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
                      isPassword: true,
                      controller: passwordController,
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
                          onTap: registration,
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

                    // Login Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signin(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
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
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
