import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Number trivia"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration:const  InputDecoration(
                hintText: "Enter a Number",
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(12.0))
                )
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){}, child:const  Text("Number Trivia")),
              ElevatedButton(onPressed: (){}, child: const Text("Random Trivia"))
            ],
          )
        ],
      ),
    );
  }
}