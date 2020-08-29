import 'package:flutter/material.dart';
import '../../screens/newStatusScreen.dart';

class ProfileDetails extends StatelessWidget {
  final String name;
  final String email;
  final String imgUrl;
  ProfileDetails(
    this.name,
    this.email,
    this.imgUrl,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: 150,
            height: 150,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
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
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: 150,
          height: 150,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
