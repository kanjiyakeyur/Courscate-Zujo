import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/profileScreen/profileDetails.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context).userDetails;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ProfileDetails(
            user['userName'],
            user['email'],
            user['imgUrl'],
          ),
        ],
      ),
    );
  }
}
//user['userName']
//FlatButton(
//            onPressed: () {
//              FirebaseAuth.instance.signOut();
//            },
//            child: Text('Logout'))
//
//
//
//
