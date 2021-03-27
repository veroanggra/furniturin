import 'package:flutter/material.dart';
import 'package:furniturin/main.dart';
import 'package:furniturin/provider/furnitur_provider.dart';
import 'package:furniturin/screens/furnitur_store_details.dart';
import 'package:furniturin/utils/Colors.dart';
import 'package:furniturin/widgets/staggered_dual_view.dart';

class FurniturStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = FurniturProvider.of(context).bloc;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: cartBarHeight, left: 10, right: 10),
      child: StaggeredDualView(
        aspectRatio: 0.82,
        itemPercent: 0.25,
        spacing: 20,
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 650),
                  pageBuilder: (context, animation, __) {
                    return FadeTransition(
                      opacity: animation,
                      child: FurniturStoreDetails(
                        product: product,
                        onProductAdded: (){
                          bloc.addProduct(product);
                        }
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              shadowColor: Colors.black45,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'list_${product.name}',
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '\Rp' + product.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      product.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: bloc.catalog.length,
      ),
    );
  }
}
