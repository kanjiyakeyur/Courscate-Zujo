import 'package:flutter/material.dart';

class OneCard extends StatelessWidget {
  final dynamic data;
  OneCard(this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          height: 60,
          color: Colors.grey.shade700,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  data['userImgUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                data['userName'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          width: double.maxFinite,
          color: Colors.grey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.yellow,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                  data['imgUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                data['description'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
