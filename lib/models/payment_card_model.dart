
  class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool ischosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.ischosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? ischosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      ischosen: ischosen ?? this.ischosen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'ischosen': ischosen,
    };
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'] as String,
      cardNumber: map['cardNumber'] as String,
      cardHolderName: map['cardHolderName'] as String,
      expiryDate: map['expiryDate'] as String,
      cvv: map['cvv'] as String,
      ischosen: map['ischosen'] as bool,
    );
  }

}

List<PaymentCardModel> dummypaymentcard = [
  PaymentCardModel(
    id: '1',
    cardNumber: '1234 5678 9012 3456',
    cardHolderName: 'William Doe',
    expiryDate: '12/25',
    cvv: '123',
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '9876 5432 1098 7654',
    cardHolderName: 'Cole Smith',
    expiryDate: '11/24',
    cvv: '456',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '9876 5432 1098 7654',
    cardHolderName: 'Jane Samy',
    expiryDate: '11/24',
    cvv: '456',
  ),
  PaymentCardModel(
    id: '4',
    cardNumber: '1234 5644 6643 1222',
    cardHolderName: 'Saif Nagy',
    expiryDate: '11/24',
    cvv: '456',
  ),
];
