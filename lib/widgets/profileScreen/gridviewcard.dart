import 'package:courscate/screens/newScreen.dart';
import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  final dynamic data;
  GridViewCard(this.data);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NewScreen.routename, arguments: data);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            data['imgUrl'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
