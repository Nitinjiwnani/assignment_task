import 'package:assignment_task/models/product_model.dart';
import 'package:assignment_task/view/product_details_screen.dart';
import 'package:get/get.dart';

import '../repository/api_response.dart';
import '../repository/controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appbarTitle = 'Product List';
  @override
  void initState() {
    super.initState();
    APIConnect().postList;
    APIConnect().getPostApi();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    // print(controller);
    print('Build state');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appbarTitle),
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: APIConnect().getPostApi(),
                builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      // crossAxisCount: 20,
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 0.6,
                      children: List.generate(
                        20,
                        (index) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    product: snapshot.data![index]),
                              )),
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Image.network(
                                    snapshot.data![index].image.toString(),
                                    fit: BoxFit.contain,
                                  ),
                                )),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                      snapshot.data![index].title
                                          .toString()
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    snapshot.data![index].category
                                        .toString()
                                        .toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GetBuilder<Controller>(builder: (_) {
                                      if (_.favourites != null) {
                                        return IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: controller.favourites!
                                                    .contains(snapshot
                                                        .data![index].id
                                                        .toString())
                                                ? Colors.deepPurple
                                                : null,
                                          ),
                                          onPressed: () async {
                                            controller.onPressFavouriteButton(
                                                snapshot.data![index].id
                                                    .toString());
                                          },
                                        );
                                      }
                                      return IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                        ),
                                        onPressed: () async {
                                          controller.onPressFavouriteButton(
                                              snapshot.data![index].id
                                                  .toString());
                                        },
                                      );
                                    }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
