import 'dart:math';

class CalculationService {
  // Calcula juros compostos com aportes mensais
  static Map<String, dynamic> calculateCompoundInterest({
    required double initialAmount,
    required double monthlyContribution,
    required double annualRate,
    required int years,
  }) {
    final months = years * 12;
    final monthlyRate = annualRate / 100 / 12;
    
    // Valor futuro do montante inicial
    final futureValueInitial = initialAmount * pow(1 + monthlyRate, months);
    
    // Valor futuro dos aportes mensais
    double futureValueContributions = 0;
    if (monthlyRate > 0) {
      futureValueContributions = monthlyContribution * 
        ((pow(1 + monthlyRate, months) - 1) / monthlyRate);
    } else {
      futureValueContributions = monthlyContribution * months;
    }
    
    final totalInvested = initialAmount + (monthlyContribution * months);
    final finalValue = futureValueInitial + futureValueContributions;
    final totalInterest = finalValue - totalInvested;
    final returnPercentage = totalInvested > 0 ? (totalInterest / totalInvested) * 100 : 0;
    
    return {
      'finalValue': finalValue,
      'totalInvested': totalInvested,
      'totalInterest': totalInterest,
      'returnPercentage': returnPercentage,
    };
  }
  
  // Calcula evolução mensal para o gráfico
  static List<Map<String, dynamic>> calculateMonthlyEvolution({
    required double initialAmount,
    required double monthlyContribution,
    required double annualRate,
    required int years,
  }) {
    final months = years * 12;
    final monthlyRate = annualRate / 100 / 12;
    final List<Map<String, dynamic>> evolution = [];
    
    double balance = initialAmount;
    double totalInvested = initialAmount;
    
    evolution.add({
      'month': 0,
      'invested': totalInvested,
      'total': balance,
      'interest': 0.0,
    });
    
    for (int month = 1; month <= months; month++) {
      balance = balance * (1 + monthlyRate) + monthlyContribution;
      totalInvested += monthlyContribution;
      final interest = balance - totalInvested;
      
      evolution.add({
        'month': month,
        'invested': totalInvested,
        'total': balance,
        'interest': interest,
      });
    }
    
    return evolution;
  }
  

  static List<Map<String, dynamic>> calculateYearlyEvolution({
    required double initialAmount,
    required double monthlyContribution,
    required double annualRate,
    required int years,
  }) {
    final List<Map<String, dynamic>> evolution = [];
    
    for (int year = 0; year <= years; year++) {
      final result = calculateCompoundInterest(
        initialAmount: initialAmount,
        monthlyContribution: monthlyContribution,
        annualRate: annualRate,
        years: year,
      );
      
      evolution.add({
        'year': year,
        'invested': result['totalInvested'],
        'total': result['finalValue'],
        'interest': result['totalInterest'],
      });
    }
    
    return evolution;
  }
}