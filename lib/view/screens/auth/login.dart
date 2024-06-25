import 'package:flutter/material.dart';

import '../../../provider/auth_provider.dart';
import '../../../utill/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../utill/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: ColorResources.COLOR_SPLASH,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogo(),
              _buildForm(),
              const SizedBox(height: 20),
              _buildLoginButton(context, loginProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/image/logo-splash.png',
      width: 200,
      height: 200,
    );
  }

  Widget _buildForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _inputDecoration(
        hintText: 'Enter User Name ...',
        icon: Icons.email,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => (value == null || value.isEmpty)
          ? 'Please enter a valid email'
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: _inputDecoration(
        hintText: 'Enter password...',
        icon: Icons.lock,
      ),
      obscureText: true,
      validator: (value) => (value == null || value.isEmpty || value.length < 3)
          ? 'Password must be at least 6 characters'
          : null,
    );
  }

  InputDecoration _inputDecoration(
      {required String hintText, required IconData icon}) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      // Adjust the padding here
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorStyle: const TextStyle(
        color: Colors.white, // Set your desired error text color here
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, AuthProvider loginProvider) {
    final BuildContext buttonContext = context; // Capture context in a variable

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff1393BA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
        onPressed: loginProvider.isLoading
            ? null
            : () {
                if (_formKey.currentState?.validate() ?? false) {
                  loginProvider
                      .login(_emailController.text, _passwordController.text)
                      .then((value) {
                    if (value.isSuccess!) {
                      Navigator.pushNamedAndRemoveUntil(
                          buttonContext,
                          Routes.getMainRoute(),
                          (Route<dynamic> route) => false);
                    } else {
                      Fluttertoast.showToast(
                          msg: value.message ?? "",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                }
              },
        child: loginProvider.isLoading
            ? CircularProgressIndicator()
            : const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }
}
