class ApisPaths {
  static users(String userId) => 'users/$userId';
  static location(String userId, String locationId) =>
      'users/$userId/locations/$locationId';
  static locations(String userId) => 'users/$userId/locations/';
  static cartitem(String userId, String productId) =>
      'users/$userId/cart/$productId';
  static cartitems(String userId) => 'users/$userId/cart/';
  static paymentCard(String userId, String paymentCardId) =>
      'users/$userId/paymentcards/$paymentCardId';
  static paymentCards(String userId) => 'users/$userId/paymentcards/';
  static favouriteProduct(String userId, String productId) =>
      'users/$userId/favourites/$productId';
  static favouriteProducts(String userId) => 'users/$userId/favourites/';
  static products() => 'products/';
  static announcments() => 'announcments/';
  static categories() => 'categories/';
  static product(String productId) => 'products/$productId';
}
