import 'package:flutter/material.dart';
import 'package:furniturin/models/furnitur_products.dart';

class FurniturStoreDetails extends StatefulWidget {
  const FurniturStoreDetails(
      {Key key, @required this.product, this.onProductAdded})
      : super(key: key);
  final FurniturProduct product;
  final VoidCallback onProductAdded;

  @override
  _FurniturStoreDetailsState createState() => _FurniturStoreDetailsState();
}

class _FurniturStoreDetailsState extends State<FurniturStoreDetails> {
  String heroTag = '';

  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = 'details';
    });
    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'list_${widget.product.name}$heroTag',
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.product.left,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          '\Rp ${widget.product.price}',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Info Produk',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    onPressed: () => null,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xFFF4C459),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Tambahkan Keranjang',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () => _addToCart(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
