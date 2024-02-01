import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/product_updation_controller.dart';

class ProductUpdationPage extends GetView<ProductUpdationController> {
  const ProductUpdationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Update Section'),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(OneRoute.homeView);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "View Products",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            Get.dialog(addProductDialog(true, 0));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Add a New Product",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        body: SafeArea(
            child: Obx(() => Column(
                  children: [
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
                              : controller.productList.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: List.generate(
                                            controller.productList.length,
                                            (index) => showProductsCard(index)),
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 60),
                                      child: Center(
                                        child: Text(
                                          " No Products available,\n Please add some",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    )),
                    )
                  ],
                ))));
  }

  Widget addProductDialog(bool isAdd, int index) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
              ),
              onChanged: (value) {
                controller.name.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.priceController,
              decoration: InputDecoration(
                hintText: "Price",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
              ),
              onChanged: (value) {
                controller.price.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.moqController,
              decoration: InputDecoration(
                hintText: "Moq",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
              ),
              onChanged: (value) {
                controller.moq.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.discountController,
              decoration: InputDecoration(
                hintText: "Discounted Price",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
              ),
              onChanged: (value) {
                controller.discountedPrice.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                isAdd
                    ? controller.addNewProduct().then((value) {
                        Get.back();
                      })
                    : controller
                        .editProduct(controller.productList[index].id ?? "")
                        .then((value) {
                        Get.back();
                      });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  isAdd ? "Add" : "Edit",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.nameController.text =
                          controller.productList[index].name ?? "";
                      controller.priceController.text =
                          controller.productList[index].price ?? "";
                      controller.moqController.text =
                          controller.productList[index].moq ?? "";
                      controller.discountController.text =
                          controller.productList[index].discountedPrice ?? "";
                      Get.dialog(addProductDialog(false, index));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      controller.deleteProduct(
                          controller.productList[index].id ?? "");
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
