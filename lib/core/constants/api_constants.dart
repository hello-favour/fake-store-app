class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Auth endpoints
  static const String login = '/auth/login';

  // Product endpoints
  static const String products = '/products';
  static String productDetail(int id) => '/products/$id';

  // Cart endpoints
  static const String carts = '/carts';
  static String cartById(int id) => '/carts/$id';

  // User endpoints
  static const String users = '/users';
  static String userById(int id) => '/users/$id';
}
