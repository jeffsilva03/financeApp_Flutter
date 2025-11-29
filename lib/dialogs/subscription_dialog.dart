import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../models/subscription.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class SubscriptionDialog extends StatefulWidget {
  final Subscription? subscription;

  const SubscriptionDialog({Key? key, this.subscription}) : super(key: key);

  @override
  State<SubscriptionDialog> createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  
  late String _category;
  late int _billingDay;
  late String _paymentMethod;
  late String _status;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  bool _showSuggestions = false;

  // Sugestões populares de assinaturas
  final Map<String, Map<String, dynamic>> _popularSubscriptions = {
    'Netflix': {'category': 'Streaming', 'amount': 55.90, 'icon': Icons.movie_rounded},
    'Spotify': {'category': 'Música', 'amount': 21.90, 'icon': Icons.music_note_rounded},
    'Disney+': {'category': 'Streaming', 'amount': 43.90, 'icon': Icons.play_circle_rounded},
    'Amazon Prime': {'category': 'Streaming', 'amount': 14.90, 'icon': Icons.storefront_rounded},
    'YouTube Premium': {'category': 'Streaming', 'amount': 24.90, 'icon': Icons.play_arrow_rounded},
    'Deezer': {'category': 'Música', 'amount': 21.90, 'icon': Icons.audiotrack_rounded},
    'HBO Max': {'category': 'Streaming', 'amount': 34.90, 'icon': Icons.theaters_rounded},
    'Apple Music': {'category': 'Música', 'amount': 21.90, 'icon': Icons.music_video_rounded},
    'iCloud': {'category': 'Produtividade', 'amount': 12.90, 'icon': Icons.cloud_rounded},
    'Microsoft 365': {'category': 'Produtividade', 'amount': 29.90, 'icon': Icons.laptop_rounded},
    'ChatGPT Plus': {'category': 'Produtividade', 'amount': 99.00, 'icon': Icons.smart_toy_rounded},
    'Canva Pro': {'category': 'Produtividade', 'amount': 54.90, 'icon': Icons.design_services_rounded},
    'Notion': {'category': 'Produtividade', 'amount': 40.00, 'icon': Icons.note_rounded},
    'Adobe Creative': {'category': 'Produtividade', 'amount': 142.00, 'icon': Icons.brush_rounded},
    'Steam': {'category': 'Jogos', 'amount': 0.00, 'icon': Icons.sports_esports_rounded},
    'Xbox Game Pass': {'category': 'Jogos', 'amount': 44.90, 'icon': Icons.gamepad_rounded},
    'PlayStation Plus': {'category': 'Jogos', 'amount': 34.90, 'icon': Icons.videogame_asset_rounded},
    'Globo Play': {'category': 'Streaming', 'amount': 24.90, 'icon': Icons.tv_rounded},
  };

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    if (widget.subscription != null) {
      _nameController.text = widget.subscription!.name;
      _amountController.text = widget.subscription!.monthlyAmount.toStringAsFixed(2).replaceAll('.', ',');
      _notesController.text = widget.subscription!.notes;
      _category = widget.subscription!.category;
      _billingDay = widget.subscription!.billingDay;
      _paymentMethod = widget.subscription!.paymentMethod;
      _status = widget.subscription!.status;
    } else {
      _category = AppSubscriptionCategories.categories.keys.first;
      _billingDay = DateTime.now().day;
      _paymentMethod = AppConstants.paymentMethods.first;
      _status = 'Ativa';
    }
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Color get _statusColor {
    switch (_status) {
      case 'Ativa':
        return AppColors.income;
      case 'Pausada':
        return AppColors.warning;
      case 'Cancelada':
        return AppColors.expense;
      default:
        return AppColors.primary;
    }
  }

  void _selectPopularService(String name, Map<String, dynamic> data) {
    setState(() {
      _nameController.text = name;
      _category = data['category'];
      if (data['amount'] > 0) {
        _amountController.text = data['amount'].toStringAsFixed(2).replaceAll('.', ',');
      }
      _showSuggestions = false;
    });
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.subscription == null) _buildQuickAdd(),
                            if (widget.subscription == null) const SizedBox(height: 24),
                            _buildNameField(),
                            const SizedBox(height: 20),
                            _buildAmountField(),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: _buildCategorySelector()),
                                const SizedBox(width: 12),
                                Expanded(child: _buildBillingDaySelector()),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: _buildPaymentMethodSelector()),
                                const SizedBox(width: 12),
                                Expanded(child: _buildStatusSelector()),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildNotesField(),
                            const SizedBox(height: 28),
                            _buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.subscriptions_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subscription == null ? 'Nova Assinatura' : 'Editar Assinatura',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Controle seus gastos recorrentes',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAdd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star_rounded, size: 18, color: AppColors.warning),
            const SizedBox(width: 8),
            const Text(
              'Assinaturas Populares',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                setState(() => _showSuggestions = !_showSuggestions);
                HapticFeedback.lightImpact();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Text(
                _showSuggestions ? 'Ocultar' : 'Ver todas',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _showSuggestions ? null : 90,
          child: _showSuggestions
              ? _buildAllSuggestions()
              : _buildQuickSuggestions(),
        ),
      ],
    );
  }

  Widget _buildQuickSuggestions() {
    final quickList = _popularSubscriptions.entries.take(6).toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quickList.length,
      itemBuilder: (context, index) {
        final entry = quickList[index];
        return _buildSuggestionChip(entry.key, entry.value);
      },
    );
  }

  Widget _buildAllSuggestions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _popularSubscriptions.entries.map((entry) {
        return _buildSuggestionChip(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildSuggestionChip(String name, Map<String, dynamic> data) {
    final color = AppSubscriptionCategories.categoryColors[data['category']] ?? AppColors.primary;
    return InkWell(
      onTap: () => _selectPopularService(name, data),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.15), color.withOpacity(0.08)],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data['icon'], size: 16, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.label_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Nome do Serviço',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Ex: Netflix, Spotify, Amazon Prime...',
            hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
            prefixIcon: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.business_rounded, size: 20, color: AppColors.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.expense, width: 2),
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Insira o nome do serviço';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.payments_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Valor Mensal',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: _amountController,
          decoration: InputDecoration(
            hintText: '0,00',
            hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
            prefixIcon: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.attach_money_rounded, size: 20, color: Colors.white),
            ),
            prefixText: 'R\$ ',
            prefixStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            suffixText: '/mês',
            suffixStyle: TextStyle(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.expense, width: 2),
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
          ],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Insira o valor';
            }
            final amount = AppFormatters.parseDouble(value);
            if (amount <= 0) {
              return 'Valor deve ser maior que zero';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.category_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Categoria',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
          ),
          child: DropdownButtonFormField<String>(
            value: _category,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            items: AppSubscriptionCategories.categories.keys.map((category) {
              final color = AppSubscriptionCategories.categoryColors[category]!;
              return DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(
                      AppSubscriptionCategories.categories[category],
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Text(category, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _category = value);
                HapticFeedback.selectionClick();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBillingDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Vencimento',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
          ),
          child: DropdownButtonFormField<int>(
            value: _billingDay,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            items: List.generate(31, (index) {
              final day = index + 1;
              return DropdownMenuItem(
                value: day,
                child: Text('Dia $day', style: const TextStyle(fontSize: 13)),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                setState(() => _billingDay = value);
                HapticFeedback.selectionClick();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.payment_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Pagamento',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
          ),
          child: DropdownButtonFormField<String>(
            value: _paymentMethod,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            items: AppConstants.paymentMethods.map((method) {
              return DropdownMenuItem(
                value: method,
                child: Text(method, style: const TextStyle(fontSize: 13)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _paymentMethod = value);
                HapticFeedback.selectionClick();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
          ),
          child: DropdownButtonFormField<String>(
            value: _status,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary, size: 20),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            items: AppConstants.subscriptionStatus.map((status) {
              Color statusColor = AppColors.income;
              if (status == 'Pausada') statusColor = AppColors.warning;
              if (status == 'Cancelada') statusColor = AppColors.expense;
              
              return DropdownMenuItem(
                value: status,
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(status, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _status = value);
                HapticFeedback.selectionClick();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(Icons.notes_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text(
                'Notas (opcional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: _notesController,
          decoration: InputDecoration(
            hintText: 'Adicione informações extras sobre esta assinatura...',
            hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.textTertiary.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.all(16),
          ),
          maxLines: 3,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: AppColors.textTertiary.withOpacity(0.3), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_statusColor, _statusColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _statusColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _saveSubscription,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.subscription == null ? Icons.add_rounded : Icons.check_rounded,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.subscription == null ? 'Adicionar' : 'Salvar',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _saveSubscription() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact();
      final subscription = Subscription(
        id: widget.subscription?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        monthlyAmount: AppFormatters.parseDouble(_amountController.text),
        billingDay: _billingDay,
        category: _category,
        paymentMethod: _paymentMethod,
        status: _status,
        notes: _notesController.text.trim(),
      );
      
      Navigator.pop(context, subscription);
    } else {
      HapticFeedback.vibrate();
    }
  }
}