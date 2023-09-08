import 'package:get/get.dart';
import 'package:tp_archi_mobile/models/user.dart';

import '../services/user_service.dart';

class UserListController extends GetxController {
  UserListController() {
    _userService = UserService();
  }

  List<User> users = [];

  late UserService _userService;

  @override
  void onInit() async {
    super.onInit();
    await getAllUsers();
  }

  Future<int> getAllUsers() async {
    users = await _userService.readAllUsers();

    update();
    return users.length;
  }
}

class HandleUserController extends GetxController {
  final UserService _userService = UserService();

  Future<int?> verifyUser(String username, String password) async {
    int? successValue = await _userService.verifyUser(username, password);
    update();
    return successValue;
  }

  Future<User> readData(int id) async {
    User user = await _userService.readUser(id);
    update();
    return user;
  }

  Future<int> createUser(User user) async {
    int successValue = await _userService.saveUser(user);
    print("createUser");
    update();
    return successValue;
  }

  Future<void> updateUser(User user) async {
    await _userService.updateUser(user);
    update();
  }

  Future<void> deleteUser(User user) async {
    await _userService.deleteUser(user.id!);
    update();
  }
}
