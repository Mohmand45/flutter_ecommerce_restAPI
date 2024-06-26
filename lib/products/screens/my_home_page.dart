import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rest_api/products/services/service_product.dart';
import 'package:rest_api/utilities/rest_api_utilities.dart';

import '../models/model_post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client = http.Client();
  Future<List<ModelPost>>? _future_list;

  void initState() {
    super.initState();
    setState(() {
      _future_list = ServiceProduct.LoadProducts();
    });
  }

  Future<http.Response> fetcAlbum() {
    return http.get(Uri.parse(RestApiUtilities.product_url));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('APIs'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
              future: _future_list,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ModelPost>> snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  if (snapshot.hasData) {
                    List<ModelPost> list = snapshot.data!;
                    if (list.length > 0) {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(
                                width: 200,
                                height: 200,
                                "${list[index].image}",
                              ),
                              Text("Price: \$ ${list[index].price}"),
                              ListTile(
                                title: Text('${list[index].title}'),
                                subtitle: Text("${list[index].description}"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return Text("Sorry no record found");
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }
}
