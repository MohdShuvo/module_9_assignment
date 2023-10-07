import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCartScreen(),
    );
  }
}

class CartItem {
  final String title;
  final String imageUrl;
  final String size;
  final double unitPrice;
  int itemCount;

  CartItem({
    required this.title,
    required this.imageUrl,
    required this.size,
    required this.unitPrice,
    required this.itemCount,
  });
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      title: 'Black T-Shirt',
      imageUrl: 'https://cdn.create.vista.com/api/media/small/168595652/stock-photo-t-shirt',
      size: 'L',
      unitPrice: 10.0,
      itemCount: 0,
    ),
    CartItem(
      title: 'Organic T-Shirt',
      imageUrl: 'https://i.ebayimg.com/images/g/2UQAAOSw~29b5W3g/s-l1600.jpg',
      size: 'xl',
      unitPrice: 15.0,
      itemCount: 0,
    ),
    CartItem(
      title: 'Jersey T-Shirt',
      imageUrl: 'https://ounass-ae.atgcdn.ae/small_light(of=webp,q=90)/pub/media/catalog/product//2/1/213778859_blu_in.jpg?1635550651.011',
      size: 'xxl',
      unitPrice: 8.0,
      itemCount: 0,
    ),
  ];

  void showCongratulationsSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Checkout successful.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(
      0.0,
          (previousValue, cartItem) =>
      previousValue + (cartItem.itemCount * cartItem.unitPrice),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                  },
                ),
              ],
            ),
            Text(
              'My Bag',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: cartItems.map((cartItem) {
                return _ShoppingCartItem(
                  cartItem: cartItem,
                  onIncrease: () {
                    setState(() {
                      cartItem.itemCount++;
                    });
                  },
                  onDecrease: () {
                    setState(() {
                      if (cartItem.itemCount > 0) {
                        cartItem.itemCount--;
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showCongratulationsSnackbar,
              child: Text('CHECK OUT'),
            ),
            SizedBox(height: 20),
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingCartItem extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  _ShoppingCartItem({
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItem.itemCount * cartItem.unitPrice;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(cartItem.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cartItem.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Size: ${cartItem.size}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Price: \$${cartItem.unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: cartItem.itemCount > 0 ? onDecrease : null,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      cartItem.itemCount.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    InkWell(
                      onTap: onIncrease,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'Total: \$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
