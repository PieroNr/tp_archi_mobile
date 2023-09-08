import 'package:flutter/material.dart';
import 'package:tp_archi_mobile/controllers/user_controller.dart';
import 'package:tp_archi_mobile/models/user.dart';
import 'package:get/get.dart';
import 'package:tp_archi_mobile/widgets/login_formfield.dart';

class UserDetails extends StatefulWidget {
  final User user;

  UserDetails({required this.user});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final HandleUserController _userController = Get.put(HandleUserController()); // Injectez le contrôleur


  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.userName);
    _passwordController = TextEditingController(text: widget.user.userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Utilisez la clé du formulaire ici
          child: Column(
            children: [
              Text(
                'ID : ${widget.user.userId}',
                style: TextStyle(fontSize: 16),
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
                controller: _usernameController,
              ),
              LoginTextField(
                hasAsterisks: true,
                controller: _passwordController,
                hintText: 'Enter your password',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Validez le formulaire avant de traiter les données
                  if (_formKey.currentState!.validate()) {
                    String newUsername = _usernameController.text;
                    String newPassword = _passwordController.text;
                    print('Nouveau nom d\'utilisateur : $newUsername');
                    print('Nouveau mot de passe : $newPassword');

                    User user = User(id: widget.user.id,userId: widget.user.userId,userName: newUsername, userPassword: newPassword);
                    await _userController.updateUser(user);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Utilisateur modifié avec succès !'),
                      ),
                    );

                    widget.user.userName = newUsername;
                    widget.user.userPassword = newPassword;

                  }
                },
                child: Text('Mettre à jour'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
