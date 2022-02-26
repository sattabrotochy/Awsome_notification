import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1528183429752-a97d0bf99b5a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHJlZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 100,
                  height: 50,
                  color: Colors.green[800],
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "150 taka",
                        style: TextStyle(color: Colors.white),
                      ))),
              Container(
                  width: 100,
                  height: 50,
                  color: Colors.green[800],
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "10 L",
                        style: TextStyle(color: Colors.white),
                      ))),
              Container(
                  width: 100,
                  height: 50,
                  color: Colors.green[800],
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "120",
                        style: TextStyle(color: Colors.white),
                      ))),




            ],
          )
        ],
      ),

    );
  }
}
