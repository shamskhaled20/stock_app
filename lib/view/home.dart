import 'package:flutter/material.dart';
import 'package:stocktaking_app/view/Check.dart';
import 'package:stocktaking_app/view/new_doc.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return NewDocScreen();
                  }));
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black,width: 2),
                  ),
                ),
              ),
              Text("New \nStocktaking \nDocument"),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Check();
                  }));
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.black,width: 2),
                  ),
                ),
              ),
              Text("Check \nInventory"),
            ],
          )
        ],
      ),
    );
  }
}
