class Subscription {
  final String id;
  final String name;
  final double monthlyAmount;
  final int billingDay;
  final String category;
  final String paymentMethod;
  final String status;
  final String notes;
  
  Subscription({
    required this.id,
    required this.name,
    required this.monthlyAmount,
    required this.billingDay,
    required this.category,
    required this.paymentMethod,
    required this.status,
    this.notes = '',
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'monthlyAmount': monthlyAmount,
      'billingDay': billingDay,
      'category': category,
      'paymentMethod': paymentMethod,
      'status': status,
      'notes': notes,
    };
  }
  
  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      name: map['name'],
      monthlyAmount: map['monthlyAmount'],
      billingDay: map['billingDay'],
      category: map['category'],
      paymentMethod: map['paymentMethod'],
      status: map['status'],
      notes: map['notes'] ?? '',
    );
  }
  
  Subscription copyWith({
    String? id,
    String? name,
    double? monthlyAmount,
    int? billingDay,
    String? category,
    String? paymentMethod,
    String? status,
    String? notes,
  }) {
    return Subscription(
      id: id ?? this.id,
      name: name ?? this.name,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
      billingDay: billingDay ?? this.billingDay,
      category: category ?? this.category,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}

