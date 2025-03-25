enum PaymentMethod {
  cash('Cash'),
  card('Credit Card'),
  applePay('Apple Pay'),
  googlePay('Google Pay');

  final String label;

  const PaymentMethod(this.label);
}
