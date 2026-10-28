import 'package:app_noticias/service/login_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  bool _carregando = false;
  String? _mensagemErro;

  Future<void> autenticar() async {
    setState(() {
      _carregando = true;
      _mensagemErro = null;
    });
    try {
      final nome = await _loginService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ususario : $nome está logado '),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _mensagemErro = e.toString().replaceFirst('Exception', '');
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person,
                size: 100,
                color: Color(0xFFEDEDED),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'senha',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              if (_mensagemErro != null) ...[
                Text(
                  _mensagemErro!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _carregando ? null : autenticar,
                child: _carregando
                    ? SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
