import 'package:flutter/material.dart';
import 'package:mini_project_shoes_app/views/components/product_card.dart';
import 'package:mini_project_shoes_app/controllers/product_controller.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
      if (!productController.isLoaded) {
      productController.getProducts();
    }

      final latestProducts = productController.products.toList()
      ..sort((a, b) => b.id.compareTo(a.id));

    // Mengambil 6 produk terbaru dari daftar yang sudah diurutkan
    final latestProductsLimited = latestProducts.take(6).toList();
  
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text( key: Key('newProducts'),
                'New Arrival',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500
                )
              ),
            ),
            Spacer(),
            IconButton(onPressed: (){
              productController.getProducts();
              QuickAlert.show(
                context: context, 
                type: QuickAlertType.loading,
                title: 'Loading...',
                text: 'Please wait while we are loading the latest products',
               
              );
            }, 
            icon: Icon(Icons.refresh_outlined)),
          ],
        ),
        GridView.builder(
          controller: ScrollController(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 12 / 18,
          ),
          shrinkWrap: true,
          itemCount: latestProductsLimited.length,
          itemBuilder: (context, index) {
             final product = latestProductsLimited[index];
            return ProductCard(product);
          },
        ),
      ],
    );
  }
}


