import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebasetut1/api/food_api.dart';
import 'package:firebasetut1/notifier/auth_notifier.dart';
import 'package:firebasetut1/notifier/food_notifier.dart';
import 'package:firebasetut1/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFood(foodNotifier);
    print(foodNotifier.foodList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Building feed screen');
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authNotifier.user != null
            ? authNotifier.user!.displayName!
            : 'Feed'),
        actions: [
          TextButton(
              onPressed: () => signOut(authNotifier),
              child: Text(
                'logOut',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(
              foodNotifier.foodList[index].image,
              width: 120,
              fit: BoxFit.fitWidth,
            ),
            title: Text(foodNotifier.foodList[index].name),
            subtitle: Text(foodNotifier.foodList[index].category),
            onTap: () {
              foodNotifier.currentFood = foodNotifier.foodList[index];
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return FoodDetail();
                }),
              );
            },
          );
        },
        itemCount: foodNotifier.foodList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
    );
  }
}
