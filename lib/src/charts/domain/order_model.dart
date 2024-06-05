class OrderBook {

  OrderBook({required this.bids, required this.asks});

  factory OrderBook.fromJson(Map<String, dynamic> json) {
    return OrderBook(
      bids: (json['bids'] as List).map((i) => Order.fromJson(i)).toList(),
      asks: (json['asks'] as List).map((i) => Order.fromJson(i)).toList(),
    );
  }
  final List<Order> bids;
  final List<Order> asks;
}

class Order {

  Order({required this.price, required this.quantity});

  factory Order.fromJson(List<dynamic> json) {
    return Order(
      price: double.parse(json[0].toString()),
      quantity: double.parse(json[1].toString()),
    );
  }
  final double price;
  final double quantity;
}
