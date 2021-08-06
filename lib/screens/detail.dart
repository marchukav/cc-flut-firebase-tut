import 'package:firebasetut1/notifier/food_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('detail screen built');
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(foodNotifier.currentFood.name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              foodNotifier.currentFood.image,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              foodNotifier.currentFood.name,
              style: TextStyle(fontSize: 40),
            ),
            Text(
              foodNotifier.currentFood.category,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            GridView.count(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 3,
              children: foodNotifier.currentFood.subingridients!
                  .map(
                    (ingredient) => Card(
                      color: Colors.black54,
                      child: Center(
                          child: Text(
                        ingredient,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
