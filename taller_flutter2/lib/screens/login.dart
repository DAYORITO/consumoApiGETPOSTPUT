import 'package:flutter/material.dart';
import 'package:taller_flutter2/screens/menu.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 
  final List<Map<String, String>> validUsers = [
    {'username': 'usuario1', 'password': 'contraseña1'},
    {'username': 'usuario2', 'password': 'contraseña2'},
   
  ];

  String? userError;
  String? passwordError;

  
  void validateInputs() {
    final enteredUser = userController.text;
    final enteredPassword = passwordController.text;
    final userExists = validUsers.any((user) => user['username'] == enteredUser);
    final passwordExists =
        validUsers.any((user) => user['password'] == enteredPassword);
    if(userExists==true && passwordExists==true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    }else{
      if (enteredUser.isEmpty || !userExists) {
        setState(() {
          userError = 'Ingresa un usuario';
        });
      } else {
        setState(() {
          userError = null;
        });
      }
      if (enteredPassword.isEmpty || !passwordExists) {
        setState(() {
          passwordError = 'Ingresa una contraseña';
        });
      } else {
        setState(() {
          passwordError = null;
        });
      }

    }

    // Verifica si el usuario y la contraseña coinciden con algún usuario válido
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inicio de sesión AppTower",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 161, 199, 255),
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Logo.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: userController,
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 5.0,
                    ),
                    labelText: 'Ingresa tu usuario',
                    errorText: userError,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 5.0,
                    ),
                    labelText: 'Ingresa tu contraseña',
                    errorText: passwordError,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    validateInputs();
                  },
                  child: const Text("Ingresar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
