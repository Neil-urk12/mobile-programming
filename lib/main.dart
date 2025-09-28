import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _registerUsernameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Validation regex patterns
  static const String _usernamePattern = r'^[a-zA-Z0-9_-]{3,20}$';
  static const String _namePattern = r'^[a-zA-Z\s]{2,50}$';
  static const String _emailPattern = r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$';
  static const String _mobilePattern = r'^[+]?[0-9]{10,15}$';
  static const String _passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  // Validation functions
  String? _validateRegisterUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Register username is required';
    }
    if (!RegExp(_usernamePattern).hasMatch(value)) {
      return 'Username must be 6-20 characters, alphanumeric/underscore/hyphen only';
    }
    return null;
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'User name is required';
    }
    if (!RegExp(_namePattern).hasMatch(value)) {
      return 'Name must be 2-50 characters, letters and spaces only';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(_emailPattern).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!RegExp(_mobilePattern).hasMatch(value)) {
      return 'Please enter a valid mobile number (10-15 digits)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(_passwordPattern).hasMatch(value)) {
      return 'Password must be at least 8 characters with uppercase, lowercase, digit, and special character';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form
      _registerUsernameController.clear();
      _userNameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _passwordController.clear();

      // Reset form validation state to clear any error messages
      _formKey.currentState!.reset();
    }
  }

  @override
  void dispose() {
    _registerUsernameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create using Flutter forms'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Register Username Field
              TextFormField(
                controller: _registerUsernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _validateRegisterUsername,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // User Name Field
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _validateUserName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // Email Address Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // Mobile Number Field
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile No.',
                  hintText: 'Enter your mobile number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: _validateMobile,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                validator: _validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: (_) => _submitForm(),
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
