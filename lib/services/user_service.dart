import 'package:tp_archi_mobile/models/user.dart';
import 'package:tp_archi_mobile/repositories/user_repository.dart';


class UserService {
  late UserRepository _repository;

  UserService() {
    _repository = UserRepository();
    print("UserService");
  }

  Future<int?> verifyUser(String username, String password) async {
    return (await _repository.verifyUser(username, password)!);
  }

  Future<int> saveUser(User user) async {
    return (await _repository.insertData(user.toMap()))!;
  }


  Future<List<User>> readAllUsers() async {
    var data = await _repository.readData();
    return data!.map((e) => User.fromMap(e)).toList();
  }

  Future<User> readUser(int id) async {
    var data = await _repository.readDataById(id);
    return User.fromMap(data!.first);
  }

  Future<int> updateUser(User user) async {
    return (await _repository.updateData(user.toMap()))!;
  }

  Future<int> deleteUser(int userId) async {
    return (await _repository.deleteDataById(userId))!;
  }
}
