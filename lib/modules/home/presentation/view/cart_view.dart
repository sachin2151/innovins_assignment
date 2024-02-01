import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';

class CartPage extends GetView<HomeController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: controller.cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return showProductsCard(index);
                      })
                  : const Center(child: Text("No Items in Cart"))),
        )
      ],
    )));
  }

  Widget showProductsCard(int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.only(left: 25, right: 25),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(controller.imagesList[index]),
            )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.productList[index].name ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                controller.productList[index].price ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
