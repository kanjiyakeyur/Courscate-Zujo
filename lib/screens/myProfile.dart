import 'package:courscate/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/profileScreen/profileDetails.dart';
import '../widgets/profileScreen/gridview.dart';

import './newStatusScreen.dart';

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
            height: 50,
            width: double.maxFinite,
            color: Colors.grey.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Status',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                OutlineButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(NewStatus.routename);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.yellow,
                  ),
                  label: Text(
                    ' New',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  borderSide: BorderSide(color: Colors.yellow),
                )
              ],
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
