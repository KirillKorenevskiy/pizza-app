enum PaymentMethod {
  cash('Cash'),
  card('Card'),
  applePay('Apple Pay'),
  googlePay('Google Pay');

  final String label;

  const PaymentMethod(this.label);
}
