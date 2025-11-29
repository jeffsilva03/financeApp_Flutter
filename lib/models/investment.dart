
class Investment {
  final String id;
  final String name;
  final double initialAmount;
  final double monthlyContribution;
  final double annualRate;
  final int years;
  final DateTime createdAt;
  
  Investment({
    required this.id,
    required this.name,
    required this.initialAmount,
    required this.monthlyContribution,
    required this.annualRate,
    required this.years,
    required this.createdAt,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initialAmount': initialAmount,
      'monthlyContribution': monthlyContribution,
      'annualRate': annualRate,
      'years': years,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  factory Investment.fromMap(Map<String, dynamic> map) {
    return Investment(
      id: map['id'],
      name: map['name'],
      initialAmount: map['initialAmount'],
      monthlyContribution: map['monthlyContribution'],
      annualRate: map['annualRate'],
      years: map['years'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
  
  Investment copyWith({
    String? id,
    String? name,
    double? initialAmount,
    double? monthlyContribution,
    double? annualRate,
    int? years,
    DateTime? createdAt,
  }) {
    return Investment(
      id: id ?? this.id,
      name: name ?? this.name,
      initialAmount: initialAmount ?? this.initialAmount,
      monthlyContribution: monthlyContribution ?? this.monthlyContribution,
      annualRate: annualRate ?? this.annualRate,
      years: years ?? this.years,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}