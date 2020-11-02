import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  Widget titleSection = Container(
//      margin: const EdgeInsets.all(15.0),
//      padding: const EdgeInsets.all(3.0),
//      decoration: BoxDecoration(
//          border: Border.all(color: Colors.blueAccent)
//      ),
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildtitleSection(
        'Panda clone',
        '100 /=',
        'assets/images/img1.jpg',
      ),
      _buildtitleSection('Baby Soap ', '70/=', 'assets/images/img2.jpg'),
      _buildtitleSection(
        'Happy wash',
        '700 /=',
        'assets/images/img3.jpg',
      ),
      _buildtitleSection(
        'Helo Panda',
        '120 /=',
        'assets/images/img4.jpg',
      ),
    ],
  ));

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _bulidButtonColumn(Colors.red, Icons.shopping_bag, 'Buy'),
        _bulidButtonColumn(Colors.pink, Icons.add_shopping_cart, 'Add Card'),
        _bulidButtonColumn(Colors.green, Icons.share, 'Share'),
      ],
    ),
  );

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Colors.pink, Colors.pink],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp)),
              ),
              title: Text(
                "Shop here....",
                style: TextStyle(fontSize: 20, color: Colors.yellow),
              ),
              centerTitle: false,
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                titleSection,
                buttonSection,
              ],
            )));
  }
}

Column _bulidButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Column _buildtitleSection(String label1, String label2, String image) {
  return Column(
    mainAxisSize: MainAxisSize.max,

    //margin: const EdgeInsets.only(top: 16),

    mainAxisAlignment: MainAxisAlignment.center,

    children: [
      Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
        // margin: const EdgeInsets.only(top:30),
        child: Image.asset(
          image,
          //width: 600,height: 240,fit: BoxFit.cover
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          label1,
          style: TextStyle(
            color: Colors.pink,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            //   fontStyle:
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          label2,
          style: TextStyle(
            color: Colors.black,
            fontSize: 35, fontWeight: FontWeight.bold,
            // backgroundColor: Colors.grey,
          ),
        ),
      ),
    ],
  );
}
