import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../services/user_service.dart';

class Loginmobile extends StatefulWidget {
  const Loginmobile({super.key});

  @override
  State<Loginmobile> createState() => _LoginmobileState();
}

class _LoginmobileState extends State<Loginmobile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Image.asset("assets/Logo.png", fit: BoxFit.cover),
              ),
              const SizedBox(height: 25),
              const Text(
                "PathAid",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "نظام نقل المرضى المتكامل",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerRight,
                child: const Text(
                  "اسم المستخدم",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: "اسم المستخدم أو البريد الإلكتروني",
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                  hintTextDirection: TextDirection.rtl,
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E60F7)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: const Text(
                  "كلمة المرور",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: "أدخل كلمة المرور",
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                  hintTextDirection: TextDirection.rtl,
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  prefixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E60F7)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(
                      color: Color(0xFF1E60F7),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E60F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0x401E60F7),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 40),

              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ليس لديك حساب؟",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "اتصل بالإدارة",
                        style: TextStyle(
                          color: Color(0xFF1E60F7),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    String input = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (input == "Doctor" && password == "Doctor") {
      Navigator.pushNamed(context, '/doctor');
      return;
    } else if (input == "Driver" && password == "Driver") {
      Navigator.pushNamed(context, '/driver');
      return;
    } else if (input == "Dis" && password == "Dis") {
      Navigator.pushNamed(context, '/dispatcher');
      return;
    } 

    if (input.isEmpty || password.isEmpty) {
      MotionToast.error(
        description: const Text(
          'يرجى إدخال اسم المستخدم وكلمة المرور',
          style: TextStyle(color: Colors.white),
        ),
        animationType: AnimationType.slideInFromTop,
        toastDuration: const Duration(seconds: 2),
        toastAlignment: Alignment.topCenter,
        displaySideBar: false,
      ).show(context);
      return;
    }

    // Extraction of username (part before @)
    String username = input;
    if (input.contains('@')) {
      username = input.split('@')[0];
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userService = UserService();
      final result = await userService.login(username: username, password: password);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (result['success'] == true) {
        final userData = result['data'];
        final String role = userData['role'] ?? '';

        if (role == 'SENDER') {
          Navigator.pushReplacementNamed(context, '/doctor');
        } else if (role == 'DRIVER') {
          Navigator.pushReplacementNamed(context, '/driver');
        } else if (role == 'COORDINATOR') {
          Navigator.pushReplacementNamed(context, '/dispatcher');
        } else {
          _showError('هذا الحساب لا يمتلك صلاحية الدخول');
        }
      } else {
        _showError(result['message'] ?? 'فشل تسجيل الدخول');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showError('حدث خطأ في الاتصال بالسيرفر');
    }
  }

  void _showError(String message) {
    MotionToast.error(
      description: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      animationType: AnimationType.slideInFromTop,
      toastDuration: const Duration(seconds: 5),
      toastAlignment: Alignment.topCenter,
      displaySideBar: false,
    ).show(context);
  }
}
