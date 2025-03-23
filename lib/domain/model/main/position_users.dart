import 'package:teqani/data/responses/main/positions/positions_response.dart';
import 'package:teqani/data/responses/main/users/users_response.dart';

class PositionUsers {
  PositionData position;
  List<UserData> users;

  PositionUsers({required this.position, required this.users});

  Map<String, dynamic> toMap() {
    String usersIds = '';
    users.forEach((user){
      if(usersIds == ''){
        usersIds = '${user.id}';
      } else {
        usersIds = '$usersIds,${user.id}';
      }
    });
    return {
      'position_id': '${position.id}',
      'users': usersIds,
    };
  }
}