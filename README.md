# 💰 FinanceApp - Aplicativo de Finanças Pessoais

---
O **FinanceApp** é um aplicativo de gestão financeira pessoal desenvolvido como parte do treinamento **SP Skills - Modalidade #08: Desenvolvimento de Apps Mobile**. O projeto integra Flutter e Firebase para oferecer uma experiência completa de controle financeiro, com foco em usabilidade, design moderno e funcionalidades práticas para o dia a dia.

### 🎯 Objetivo

Criar uma ferramenta que simplifique a gestão financeira pessoal, permitindo que usuários tenham controle total sobre suas receitas, despesas, investimentos e assinaturas recorrentes, tudo em um único lugar, de forma intuitiva e segura.

---

## ✨ Funcionalidades

### 📊 Dashboard Inteligente
- Visão geral consolidada das finanças
- Gráficos interativos de receitas e despesas
- Indicadores de performance financeira
- Resumo mensal e anual

### 💸 Controle de Transações
- Registro rápido de receitas e despesas
- Categorização automática e personalizada
- Histórico completo de movimentações
- Filtros avançados por período e categoria

### 🔄 Gestão de Assinaturas
- Monitoramento de serviços recorrentes
- Alertas de vencimento
- Controle de gastos mensais fixos
- Identificação de assinaturas não utilizadas

### 📈 Simulador de Investimentos
- Calculadora de juros compostos
- Projeções de investimentos
- Diferentes cenários de aplicação
- Comparativo de modalidades

### 🔐 Autenticação Segura
- Sistema completo de login e registro
- Autenticação via Firebase Auth
- Recuperação de senha
- Validação de dados em tempo real

---

## 🛠️ Tecnologias

### Frontend
- **Flutter** - Framework multiplataforma
- **Dart** - Linguagem de programação
- **Material Design 3** - Design system moderno

### Backend
- **Firebase Authentication** - Gerenciamento de usuários
- **Cloud Firestore** - Banco de dados NoSQL em tempo real
- **Cloud Functions** - Funções serverless
- **Firebase Storage** - Armazenamento de arquivos

### Arquitetura
- **Clean Code** - Código limpo e organizado
- **Separação de Responsabilidades** - Camadas bem definidas
- **Provider/Riverpod** - Gerenciamento de estado
- **Repository Pattern** - Abstração de dados

---

## 🚀 Instalação

### Pré-requisitos

```bash
# Flutter SDK (versão 3.0 ou superior)
flutter --version

# Dart SDK
dart --version

# Firebase CLI
firebase --version
```

### Passo a Passo

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/finance-app.git
cd finance-app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Configure o Firebase**
```bash
# Instale o FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure o projeto Firebase
flutterfire configure
```

4. **Execute o aplicativo**
```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

---

## 📦 Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── providers/
└── main.dart
```

---


## 🔧 Funcionalidades Técnicas

### ✅ Implementações Destacadas

- **Interface Responsiva** - Adaptação automática para diferentes tamanhos de tela
- **Persistência Offline** - Funcionamento sem conexão com sincronização automática
- **Validações em Tempo Real** - Feedback imediato para o usuário
- **Tratamento de Erros** - Sistema robusto de error handling
- **Componentes Reutilizáveis** - Biblioteca de widgets personalizados
- **Performance Otimizada** - Carregamento rápido e fluido
- **Testes Automatizados** - Cobertura de testes unitários e de widget

---

## 📚 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  provider: ^latest
  intl: ^latest
  charts_flutter: ^latest
  shared_preferences: ^latest
```

---

## 🗺️ Roadmap

- [ ] Integração com bancos via Open Banking
- [ ] Exportação de relatórios em PDF
- [ ] Modo escuro
- [ ] Notificações push personalizadas
- [ ] Metas financeiras
- [ ] Suporte multilíngue
- [ ] Versão para desktop (Windows, macOS, Linux)

---

---

## 👨‍💻 Autor

Desenvolvido por Jefferson Silva durante os treinamentos para a **SP Skills - Modalidade #08**

### 💡 Motivação

Este projeto reflete meu compromisso em desenvolver soluções tecnológicas que impactem positivamente o dia a dia das pessoas. Mais do que código, busco criar ferramentas que resolvam problemas reais, simplifiquem tarefas cotidianas e empoderem usuários a tomar melhores decisões financeiras.

---

## 📞 Contato

- **LinkedIn**: [Jefferson Silva](https://www.linkedin.com/in/jefferson-jsilva/)
- **GitHub**: [Jeff Silva](https://github.com/jeffsilva03)
- **Email**: contato@jeffcode.com.br

---

<div align="center">


</div>

