import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/model.dart';
import '../service/api.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<Modelh> newsList = [];

  void getapi(name) {
    Api.get(name).then((data) {
      Map resultBody = json.decode(data.body);

      if (resultBody['success'] == true) {
        setState(() {
          Iterable result = resultBody['result'];
          newsList = result.map((newsListt) => Modelh(newsListt)).toList();
        });
      } else {
        const SnackBar(content: Text("Something's went wrong!"));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getapi(name);
  }

  TextEditingController nameController = TextEditingController();
  String textt = "ankara";
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (newsList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Appbar(),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Body(context),
      );
    }
  }

  // ignore: non_constant_identifier_names
  Center Body(BuildContext context) {
    return Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        name.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Image.network(newsList[0].icon,
          width: MediaQuery.of(context).size.width / 4),
      Text(
        "${double.parse(newsList[0].degree).round().toString()}°C",
        style: const TextStyle(
          fontSize: 70.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        newsList[0].description,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(
        height: 10,
      ),

//Liste

      Expanded(
        child: ListView.separated(
          itemCount: newsList.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      (newsList[index + 1].day),
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Image.network(
                    newsList[index + 1].icon,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "${double.parse(newsList[index + 1].min).round()}°",
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "${double.parse(newsList[index + 1].max).round()}°",
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.transparent,
            );
          },
        ),
      ),
    ]));
  }

  // ignore: non_constant_identifier_names
  Column Appbar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 30,
                width: 250,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Şehir adını yazın',
                  ),
                  onChanged: (text) {
                    setState(() {
                      textt = text;
                    });
                  },
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  name = textt;
                  getapi(name);
                  nameController.text = "";
                });
              },
              icon: const Icon(
                Icons.location_pin,
                size: 30,
                color: Colors.black,
              ),
            )
          ],
        ),
      ],
    );
  }
}
