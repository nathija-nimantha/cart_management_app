import 'dart:async';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {

    return [
      Product(
        id: 'P001',
        name: 'Keerisamba Retail',
        price: 105.00,
        discount: 5.00,
        stock: 3000,
        image: '',
        description: 'Keerisamba Retail 1kg',
      ),
      Product(
        id: 'P002',
        name: 'Keerisamba 5Kg',
        price: 525.00,
        discount: 25.00,
        stock: 200,
        image: '',
        description: 'Keerisamba 5Kg',
      ),
      Product(
        id: 'P003',
        name: 'Keerisamba 10Kg',
        price: 995.00,
        discount: 50.00,
        stock: 36,
        image: '',
        description: 'Keerisamba 10Kg',
      ),
      Product(
        id: 'P004',
        name: 'Keerisamba 50Kg',
        price: 4100.00,
        discount: 200.00,
        stock: 36,
        image: '',
        description: 'Keerisamba 50Kg',
      ),
      Product(
        id: 'P005',
        name: 'Red Raw Rice',
        price: 60.00,
        discount: 2.00,
        stock: 6000,
        image: '',
        description: 'Red Raw Rice 1kg',
      ),
      Product(
        id: 'P006',
        name: 'Red Raw Rice 10Kg Pack',
        price: 560.00,
        discount: 20.00,
        stock: 300,
        image: '',
        description: 'Red Raw Rice 10kg Pack',
      ),
      Product(
        id: 'P007',
        name: 'Red Raw Rice 50Kg Pack',
        price: 5230.00,
        discount: 150.00,
        stock: 80,
        image: '',
        description: 'Red Raw Rice 50kg Pack',
      ),
      Product(
        id: 'P008',
        name: 'White Raw Rice 5Kg Pack',
        price: 275.00,
        discount: 10.00,
        stock: 130,
        image: '',
        description: 'White Raw Rice 5kg Pack',
      ),
      Product(
        id: 'P009',
        name: 'White Raw Rice 50Kg Pack',
        price: 2600.00,
        discount: 100.00,
        stock: 13,
        image: '',
        description: 'White Raw Rice 50kg Pack',
      ),
    ];
  }
}
