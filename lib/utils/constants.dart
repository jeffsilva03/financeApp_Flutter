import 'package:flutter/material.dart';

class AppColors {
  // Cores principais - Esquema moderno e vibrante
  static const primary = Color(0xFF6366F1);
  static const primaryDark = Color(0xFF4F46E5);
  static const primaryLight = Color(0xFF818CF8);
  static const secondary = Color(0xFF10B981);
  static const accent = Color(0xFFF59E0B);
  
  // Cores de fundo - Design clean
  static const background = Color(0xFFF8FAFC);
  static const cardBackground = Colors.white;
  static const darkBackground = Color(0xFF0F172A);
  static const darkCard = Color(0xFF1E293B);
  
  // Cores de texto
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textTertiary = Color(0xFF94A3B8);
  static const textDark = Color(0xFFF1F5F9);
  
  // Cores funcionais
  static const income = Color(0xFF10B981);
  static const expense = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);
  static const success = Color(0xFF22C55E);
  
  // Gradientes premium
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const incomeGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const expenseGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const darkGradient = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF334155)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFE2E8F0),
      Color(0xFFF1F5F9),
      Color(0xFFE2E8F0),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment(-1.0, -0.5),
    end: Alignment(1.0, 0.5),
  );
}


class AppCategories {
  static const Map<String, IconData> expenseCategories = {
    'Alimentação': Icons.restaurant,
    'Transporte': Icons.directions_car,
    'Moradia': Icons.home,
    'Saúde': Icons.local_hospital,
    'Lazer': Icons.sports_esports,
    'Educação': Icons.school,
    'Compras': Icons.shopping_bag,
    'Outros': Icons.more_horiz,
  };
  
  static const Map<String, IconData> incomeCategories = {
    'Salário': Icons.account_balance_wallet,
    'Freelance': Icons.work,
    'Investimentos': Icons.trending_up,
    'Presente': Icons.card_giftcard,
    'Outros': Icons.more_horiz,
  };
  
  static const Map<String, Color> categoryColors = {
    'Alimentação': Color(0xFFFF6B6B),
    'Transporte': Color(0xFF4ECDC4),
    'Moradia': Color(0xFF45B7D1),
    'Saúde': Color(0xFFFFA07A),
    'Lazer': Color(0xFF98D8C8),
    'Educação': Color(0xFFF7DC6F),
    'Compras': Color(0xFFBB8FCE),
    'Salário': Color(0xFF52C41A),
    'Freelance': Color(0xFF1890FF),
    'Investimentos': Color(0xFF722ED1),
    'Presente': Color(0xFFEB2F96),
    'Outros': Color(0xFF8C8C8C),
  };
}

class AppSubscriptionCategories {
  static const Map<String, IconData> categories = {
    'Streaming': Icons.play_circle_outline,
    'Música': Icons.music_note,
    'Produtividade': Icons.work_outline,
    'Academia': Icons.fitness_center,
    'Jogos': Icons.sports_esports,
    'Software': Icons.computer,
    'Notícias': Icons.newspaper,
    'Outros': Icons.more_horiz,
  };
  
  static const Map<String, Color> categoryColors = {
    'Streaming': Color(0xFFE50914),
    'Música': Color(0xFF1DB954),
    'Produtividade': Color(0xFF4285F4),
    'Academia': Color(0xFFFF6B00),
    'Jogos': Color(0xFF9146FF),
    'Software': Color(0xFF0078D7),
    'Notícias': Color(0xFF000000),
    'Outros': Color(0xFF8C8C8C),
  };
}

class AppConstants {
  static const String appName = 'SmartMoney';
  static const String userEmail = 'usuario@smartmoney.com';
  static const String userName = 'Usuário SmartMoney';
  
  static const double borderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double spacing = 16.0;
  
  static const List<String> paymentMethods = [
    'Cartão de Crédito',
    'Débito Automático',
    'Boleto',
    'Pix',
    'Dinheiro',
  ];
  
  static const List<String> subscriptionStatus = [
    'Ativa',
    'Pausada',
    'Cancelada',
  ];
}