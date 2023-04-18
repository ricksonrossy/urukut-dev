import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../cadastro/cadastro_page.dart';
import '../home/home_page.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
//variáveis
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urukut - Diário Escolar'),
      ),
      body: ListView(
        padding: EdgeInsets.all(65),
        children: [
          Image.asset(
            'lib/assets/fordrawer-background.png',
            height: 200,
            width: 200,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Seu Email'),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(
              label: Text('Sua Senha'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text('Entrar', style: TextStyle(fontSize: 17)),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => cadastroPage(),
                ),
              );
            },
            child: Text('Criar sua Conta', style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário Não Encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha está errada'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
