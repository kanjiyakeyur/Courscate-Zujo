import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/profileScreen/profileDetails.dart';
import '../widgets/profileScreen/gridview.dart';

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
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            height: 35,
            width: double.maxFinite,
            color: Colors.grey.shade900,
            child: Text(
              'Your Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridV(),
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
