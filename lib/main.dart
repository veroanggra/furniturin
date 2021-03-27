import 'package:flutter/material.dart';
import 'package:furniturin/bloc/furnitur_store_bloc.dart';
import 'package:furniturin/provider/furnitur_provider.dart';
import 'package:furniturin/screens/furnitur_store_cart.dart';
import 'package:furniturin/screens/furnitur_store_list.dart';
import 'package:furniturin/utils/Colors.dart';

void main() {
  runApp(MyApp());
}

const cartBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 750);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniturin Store',
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      home: GroceryStoreHome(),
    );
  }
}

class GroceryStoreHome extends StatefulWidget {
  @override
  _GroceryStoreHomeState createState() => _GroceryStoreHomeState();
}

class _GroceryStoreHomeState extends State<GroceryStoreHome> {
  final bloc = FurniturStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(FurniturState state, Size size) {
    if (state == FurniturState.normal) {
      return -cartBarHeight + kToolbarHeight;
    } else if (state == FurniturState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeight / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel(FurniturState state, Size size) {
    if (state == FurniturState.normal) {
      return size.height - cartBarHeight;
    } else if (state == FurniturState.cart) {
      return cartBarHeight / 2;
    }
    return 0.0;
  }

  double _getTopForAppBar(FurniturState state) {
    if (state == FurniturState.normal) {
      return 0.0;
    } else if (state == FurniturState.cart) {
      return -cartBarHeight;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FurniturProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, __) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: _panelTransition,
                  left: 0,
                  right: 0,
                  top: _getTopForWhitePanel(bloc.furniturState, size),
                  height: size.height - kToolbarHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: FurniturStoreList(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: _panelTransition,
                  left: 0,
                  right: 0,
                  top: _getTopForBlackPanel(bloc.furniturState, size),
                  height: size.height - kToolbarHeight,
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalGesture,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: AnimatedSwitcher(
                              duration: _panelTransition,
                              child: SizedBox(
                                height: kToolbarHeight,
                                child: bloc.furniturState == FurniturState.normal
                                  ? Row(
                                      children: [
                                        Text(
                                          'Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Row(
                                                children: List.generate(
                                                  bloc.cart.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Stack(
                                                      children: [
                                                        Hero(
                                                          tag: 'list_${bloc.cart[index].product.name}details',
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                AssetImage(
                                                              bloc
                                                                  .cart[index]
                                                                  .product
                                                                  .image,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Colors.red,
                                                            child: Text(
                                                              bloc.cart[index]
                                                                  .quantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFF4C459),
                                          child: Text(
                                            bloc.totalCartElements().toString(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ),
                            ),
                          ),
                          Expanded(
                            child: FurniturStoreCart(),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.decelerate,
                  duration: _panelTransition,
                  top: _getTopForAppBar(bloc.furniturState),
                  left: 0,
                  right: 0,
                  child: _AppBarGrocery(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0),
      child: Container(
        padding: const EdgeInsets.only(top: 15.0),
        height: kToolbarHeight,
        color: backgroundColor,
        child: Row(
          children: [
            BackButton(
              color: Colors.black,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                "Furniturin",
                style: TextStyle(color: Colors.black),
              ),
            ),
            IconButton(icon: Icon(Icons.settings), onPressed: () => null)
          ],
        ),
      ),
    );
  }
}
