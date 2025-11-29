import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction.dart' as models;
import '../models/subscription.dart';
import '../models/investment.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Verificar se há usuário autenticado
  void _checkAuth() {
    if (_userId == null) {
      throw Exception('Usuário não autenticado');
    }
  }

  
  Future<void> enableOfflinePersistence() async {
    try {
      await _firestore.settings;
    } catch (e) {
      print('Erro ao configurar persistência: $e');
    }
  }

  // Adicionar transação
  Future<void> addTransaction(models.Transaction transaction) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());
    } catch (e) {
      print('Erro ao adicionar transação: $e');
      rethrow;
    }
  }

  // Obter todas as transações
  Stream<List<models.Transaction>> getTransactions() {
    _checkAuth();
    return _firestore
        .collection('users')
        .doc(_userId!)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              return models.Transaction.fromMap(data);
            } catch (e) {
              print('Erro ao processar transação ${doc.id}: $e');
              return null;
            }
          })
          .whereType<models.Transaction>()
          .toList();
    });
  }

  // Obter transações de um mês específico
  Stream<List<models.Transaction>> getTransactionsByMonth(DateTime date) {
    _checkAuth();
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59);

    return _firestore
        .collection('users')
        .doc(_userId!)
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              return models.Transaction.fromMap(data);
            } catch (e) {
              print('Erro ao processar transação ${doc.id}: $e');
              return null;
            }
          })
          .whereType<models.Transaction>()
          .toList();
    });
  }

  // Atualizar transação
  Future<void> updateTransaction(models.Transaction transaction) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('transactions')
          .doc(transaction.id)
          .update(transaction.toMap());
    } catch (e) {
      print('Erro ao atualizar transação: $e');
      rethrow;
    }
  }

  // Excluir transação
  Future<void> deleteTransaction(String transactionId) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('transactions')
          .doc(transactionId)
          .delete();
    } catch (e) {
      print('Erro ao excluir transação: $e');
      rethrow;
    }
  }

 

  // Adicionar assinatura
  Future<void> addSubscription(Subscription subscription) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('subscriptions')
          .doc(subscription.id)
          .set(subscription.toMap());
    } catch (e) {
      print('Erro ao adicionar assinatura: $e');
      rethrow;
    }
  }

  // Obter todas as assinaturas
  Stream<List<Subscription>> getSubscriptions() {
    _checkAuth();
    return _firestore
        .collection('users')
        .doc(_userId!)
        .collection('subscriptions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              return Subscription.fromMap(data);
            } catch (e) {
              print('Erro ao processar assinatura ${doc.id}: $e');
              return null;
            }
          })
          .whereType<Subscription>()
          .toList();
    });
  }

  // Obter assinaturas ativas
  Stream<List<Subscription>> getActiveSubscriptions() {
    _checkAuth();
    return _firestore
        .collection('users')
        .doc(_userId!)
        .collection('subscriptions')
        .where('status', isEqualTo: 'Ativa')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              return Subscription.fromMap(data);
            } catch (e) {
              print('Erro ao processar assinatura ${doc.id}: $e');
              return null;
            }
          })
          .whereType<Subscription>()
          .toList();
    });
  }

  // Atualizar assinatura
  Future<void> updateSubscription(Subscription subscription) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('subscriptions')
          .doc(subscription.id)
          .update(subscription.toMap());
    } catch (e) {
      print('Erro ao atualizar assinatura: $e');
      rethrow;
    }
  }

  // Excluir assinatura
  Future<void> deleteSubscription(String subscriptionId) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('subscriptions')
          .doc(subscriptionId)
          .delete();
    } catch (e) {
      print('Erro ao excluir assinatura: $e');
      rethrow;
    }
  }

  // Adicionar investimento
  Future<void> addInvestment(Investment investment) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('investments')
          .doc(investment.id)
          .set(investment.toMap());
    } catch (e) {
      print('Erro ao adicionar investimento: $e');
      rethrow;
    }
  }

  // Obter todos os investimentos
  Stream<List<Investment>> getInvestments() {
    _checkAuth();
    return _firestore
        .collection('users')
        .doc(_userId!)
        .collection('investments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            try {
              final data = doc.data();
              return Investment.fromMap(data);
            } catch (e) {
              print('Erro ao processar investimento ${doc.id}: $e');
              return null;
            }
          })
          .whereType<Investment>()
          .toList();
    });
  }

  // Excluir investimento
  Future<void> deleteInvestment(String investmentId) async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('investments')
          .doc(investmentId)
          .delete();
    } catch (e) {
      print('Erro ao excluir investimento: $e');
      rethrow;
    }
  }

  // Salvar dados do perfil do usuário
  Future<void> saveUserProfile({
    required String name,
    required String email,
    String? photoUrl,
  }) async {
    try {
      _checkAuth();
      
      final data = <String, dynamic>{
        'name': name,
        'email': email,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      // Adicionar photoUrl apenas se não for null
      if (photoUrl != null) {
        data['photoUrl'] = photoUrl;
      }
      
      // Se o documento não existe, adicionar createdAt
      final docRef = _firestore.collection('users').doc(_userId!);
      final docSnapshot = await docRef.get();
      
      if (!docSnapshot.exists) {
        data['createdAt'] = FieldValue.serverTimestamp();
      }
      
      await docRef.set(data, SetOptions(merge: true));
    } catch (e) {
      print('Erro ao salvar perfil: $e');
      rethrow;
    }
  }

  // Obter dados do perfil
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      _checkAuth();
      final doc = await _firestore.collection('users').doc(_userId!).get();
      return doc.data();
    } catch (e) {
      print('Erro ao obter perfil: $e');
      return null;
    }
  }

  // Excluir todos os dados do usuário
  Future<void> deleteAllUserData() async {
    try {
      _checkAuth();
      final batch = _firestore.batch();

      // Excluir transações
      final transactions = await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('transactions')
          .get();
      for (var doc in transactions.docs) {
        batch.delete(doc.reference);
      }

      // Excluir assinaturas
      final subscriptions = await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('subscriptions')
          .get();
      for (var doc in subscriptions.docs) {
        batch.delete(doc.reference);
      }

      // Excluir investimentos
      final investments = await _firestore
          .collection('users')
          .doc(_userId!)
          .collection('investments')
          .get();
      for (var doc in investments.docs) {
        batch.delete(doc.reference);
      }

      // Excluir perfil do usuário
      batch.delete(_firestore.collection('users').doc(_userId!));

      await batch.commit();
    } catch (e) {
      print('Erro ao excluir dados do usuário: $e');
      rethrow;
    }
  }

  // Verificar conexão com Firestore
  Future<bool> checkConnection() async {
    try {
      _checkAuth();
      await _firestore
          .collection('users')
          .doc(_userId!)
          .get(const GetOptions(source: Source.server));
      return true;
    } catch (e) {
      print('Erro de conexão com Firestore: $e');
      return false;
    }
  }
}