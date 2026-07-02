# 🌱 Cresce, Brotinho!

App para acompanhamento lúdico da rega de plantas, desenvolvido como trabalho final da disciplina de Desenvolvimento para Dispositivos Móveis (DDM) no IFSC Campus Tubarão.

## 👥 Autores

- Bruna Hreisemnou Ribeiro
- Mirela Silveira Corrêa
- Pedro Henrique Martins Santos

## 📱 Sobre o App

O usuário faz login, cadastra suas plantas e registra as regas do dia a dia. Cada planta tem uma localização geográfica associada, visualizada no mapa. O app incentiva o cuidado contínuo com as plantas de forma simples e visual.

## 🧩 Funcionalidades

- Login e cadastro de usuário com autenticação via Firebase
- Tela home com botões para plantar (cadastrar nova planta) e regar
- Cadastro de plantas com nome e localização geográfica (GPS)
- Visualização de plantas no mapa
- Perfil do usuário
- Navegação entre telas por barra inferior (navbar)

## 🛠️ Tecnologias

- Flutter / Dart
- Provider (gerenciamento de estado)
- Firebase Authentication (autenticação)
- SQLite via sqflite (armazenamento local de plantas e regas)
- Geolocator (GPS)
- Google Maps / localização

## 📂 Estrutura do Projeto

```
lib/
  model/
  provider/
  view/
  widgets/
  service/
  util/
```

## ▶️ Como Rodar

1. Clone o repositório
2. Rode `flutter pub get`
3. Conecte um dispositivo ou inicie um emulador
4. Rode `flutter run`
