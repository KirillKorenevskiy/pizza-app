class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  static final empty = MyUser(
		userId: '', 
		email: '', 
		name: '',
    hasActiveCart: false,
	);

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }
}