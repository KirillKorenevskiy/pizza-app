class MyUser {
  final String userId;
  final String email;
  final String name;
  final bool hasActiveCart;

  const MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  static const empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
  );

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }

  MyUser copyWith({
    String? userId,
    String? email,
    String? name,
    bool? hasActiveCart,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      hasActiveCart: hasActiveCart ?? this.hasActiveCart,
    );
  }
}
