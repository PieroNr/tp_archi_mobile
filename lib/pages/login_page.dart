import 'package:flutter/material.dart';
import 'package:tp_archi_mobile/controllers/user_controller.dart';
import 'package:tp_archi_mobile/models/user.dart';
import 'package:tp_archi_mobile/pages/register_page.dart';
import 'package:tp_archi_mobile/pages/user_details.dart';
import 'package:get/get.dart';
import 'package:tp_archi_mobile/repositories/user_repository.dart';
import 'package:tp_archi_mobile/widgets/login_formfield.dart';


class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HandleUserController _userController = Get.put(HandleUserController()); // Injectez le contrôleur
  final UserRepository _userRepository = Get.put(UserRepository()); // Injectez le contrôleur

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/login-image.png',
                height: 200,
              ),
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
                    int? userId = await _userController.verifyUser(userNameController.text, passwordController.text);
                    print(userId);

                    if (userId != -1 && userId != null) {
                      User user = await _userController.readData(userId);
                      print(user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(
                              user: user
                          ),
                        ),
                      );
                    } else {
                      // Connexion échouée, affichez un message d'erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nom d\'utilisateur ou mot de passe incorrect.'),
                        ),
                      );
                    }

                  }
                },
                child: Text('Connexion'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text('Créer un nouveau compte'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
