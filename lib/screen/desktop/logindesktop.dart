import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path_aid/components.dart';
import '../../services/user_service.dart';

class Logindesktop extends StatefulWidget {
  const Logindesktop({super.key});

  @override
  State<Logindesktop> createState() => _LogindesktopState();
}

class _LogindesktopState extends State<Logindesktop> {

  String username = "";
  String password = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundIMG_login.png"),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      Image.asset("assets/Logo.png", width: 300),
                      SansBold(text: "PathAid", size: 60),
                      Sans(
                        text: "هنا نظام لادارة عمليات النقل بواسطة الاسعاف",
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40.0),
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.2,
                        ),
                        offset: Offset(0, 5),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Input(
                        label: "Username",
                        hint: "Username",
                        maxLine: 1,
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Input(
                        label: "Password",
                        hint: "Password",
                        maxLine: 1,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        onPressed: _isLoading ? null : () async {
                          String input = username.trim();
                          String pass = password.trim();

                          // Test Login Logic
                          if (input == "Admin" && pass == "Admin") {
                            Navigator.pushNamed(context, '/admin');
                            return;
                          }

                          if (input.isEmpty || pass.isEmpty) {
                            MotionToast.error(
                              description: const Text("يرجى إدخال اسم المستخدم وكلمة المرور"),
                              toastAlignment: Alignment.topCenter,
                            ).show(context);
                            return;
                          }

                          setState(() => _isLoading = true);

                          // Extraction of username (part before @)
                          String loginUsername = input;
                          if (input.contains('@')) {
                            loginUsername = input.split('@')[0];
                          }

                          try {
                            final result = await UserService().login(
                              username: loginUsername,
                              password: pass,
                            );

                            if (!mounted) return;
                            setState(() => _isLoading = false);

                            if (result['success'] == true) {
                              final String role = result['data']['role'] ?? '';
                              if (role == 'ADMIN') {
                                Navigator.pushReplacementNamed(context, '/admin');
                              } else {
                                _showError('هذا الحساب لا يمتلك صلاحية الدخول');
                              }
                            } else {
                              _showError(result['message'] ?? 'فشل تسجيل الدخول');
                            }
                          } catch (e) {
                            if (!mounted) return;
                            setState(() => _isLoading = false);
                            _showError('حدث خطأ في الاتصال بالسيرفر');
                          }
                        },
                        color: const Color.fromARGB(255, 98, 247, 235),
                        disabledColor: const Color.fromARGB(255, 98, 247, 235).withOpacity(0.7),
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    MotionToast.error(
      description: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      animationType: AnimationType.slideInFromTop,
      toastDuration: const Duration(seconds: 2),
      toastAlignment: Alignment.topCenter,
      displaySideBar: false,
    ).show(context);
  }
}
