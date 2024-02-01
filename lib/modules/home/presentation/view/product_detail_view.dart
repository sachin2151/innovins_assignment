import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';

class ProductDetailPageArguments {
  ProductDetailPageArguments({
    required this.data,
    required this.image,
  });

  final ProductListModel? data;
  final String? image;
}

class ProductDetailPage extends GetView<HomeController> {
  ProductDetailPage({super.key});

  final ProductDetailPageArguments arguments = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(arguments.image ?? ""),
                    fit: BoxFit.fill)),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 300),
            padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arguments.data?.name ?? "",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${arguments.data?.price ?? ""} € / piece",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800),
                ),
                Text(
                  "~ ${arguments.data?.discountedPrice ?? ""} gr / piece",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Spain",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Lettuce (Lactuca sativa) is an annual plant of the family Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled.",
                  style: TextStyle(height: 1.7),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: const Icon(Icons.favorite_outline),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // controller.addItemsToCart(index)
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[300]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(arguments.data?.isCart ?? false
                                  ? "ADDED"
                                  : "ADD TO CART")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
