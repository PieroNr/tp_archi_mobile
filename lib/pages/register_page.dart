import 'package:flutter/material.dart';
import 'package:tp_archi_mobile/controllers/user_controller.dart';
import 'package:tp_archi_mobile/models/user.dart';
import 'package:tp_archi_mobile/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:tp_archi_mobile/widgets/login_formfield.dart';


class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HandleUserController _userController = Get.put(HandleUserController()); // Injectez le contrôleur
  final UserListController _userListController = Get.put(UserListController()); // Injectez le contrôleur

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<int> generateUserId() async {
    int usersCount = await _userListController.getAllUsers();
    int newUserId = usersCount + 1;

    return newUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginTextField(
                hintText: "Nom d'utilisateur",
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 5) {
                    return "Votre nom d'utilisateur doit contenir au moins 5 caractères";
                  } else if (value != null && value.isEmpty) {
                    return "Veuillez saisir votre nom d'utilisateur";
                  }
                  return null;
                },
                controller: userNameController,
              ),
              LoginTextField(
                hasAsterisks: true,
                controller: passwordController,
                hintText: 'Enter your password',
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    int newUserId = await generateUserId();
                    User user = User(userId: newUserId,userName: userNameController.text, userPassword: passwordController.text);
                    int? userId = await _userController.createUser(user);
                    if (userId == -1) {
                      // L'utilisateur existe déjà, affichez un message d'erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nom d\'utilisateur déjà utilisé. Choisissez un autre.'),
                        ),
                      );
                    } else if (userId != null) {
                      // L'inscription a réussi, redirigez l'utilisateur vers la page de connexion
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    }
                  }
                },
                child: Text('Inscription'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
