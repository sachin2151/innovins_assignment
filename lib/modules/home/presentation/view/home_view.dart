import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';
import 'package:innovins_assignment/modules/home/presentation/view/cart_view.dart';
import 'package:innovins_assignment/modules/home/presentation/view/product_detail_view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List pages = [
      productListWidget(),
      const CartPage(),
      productListWidget(),
    ];
    return Obx(() => Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 235, 235),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            controller.bottomNavSelectedIndex.value == 1 ? "Cart Items" : "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.bottomNavSelectedIndex.value,
          onTap: (index) {
            controller.bottomNavSelectedIndex.value = index;
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: ""),
          ],
        ),
        body: pages[controller.bottomNavSelectedIndex.value]));
  }

  Widget productListWidget() {
    return Obx(() => Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 170,
                width: 170,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/bg_tree.png'),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vegetables",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  Container(
                    height: 90,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: controller.isApiLoading.value
                          ? const Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.purple,
                              )),
                            )
                          : Column(
                              children: List.generate(
                                  controller.productList.length,
                                  (index) => showProductsCard(index)),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget showProductsCard(int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(OneRoute.productDetailView,
            arguments: ProductDetailPageArguments(
                data: controller.productList[index],
                image: controller.imagesList[index]));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${controller.productList[index].price ?? ""} € / piece",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: const Icon(Icons.favorite_outline),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItemsToCart(index);
                      },
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  controller.productList[index].isCart ?? false
                                      ? Colors.green
                                      : Colors.white),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
