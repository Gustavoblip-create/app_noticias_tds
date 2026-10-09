import 'package:app_noticias/model/noticia.dart';
import 'package:app_noticias/service/noticias_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteApi extends StatefulWidget {
  const TesteApi({super.key});

  @override
  State<TesteApi> createState() => _TesteApiState();
}

class _TesteApiState extends State<TesteApi> {
  String mensagem = 'toque no botão para testar';

  final NoticiasService _noticiasService = NoticiasService();
  late Future<List<Noticia>> _listanoticias;

  Future<void> carregarNoticia() async {
    _listanoticias = _noticiasService.getNoticias();

    List<Noticia> noticia = await _listanoticias;

    print('---Teste de console--- ');
    print('Qauntidade de noticias: ${noticia.length}');
  }

  Future<void> testar() async {
    try {
      final resposta = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/noticias'),
      );

      if (resposta.statusCode == 200) {
        mensagem = 'conectou com sucesso';
      } else {
        mensagem = 'Api respondeu  com erro ${resposta.statusCode}';
      }
    } catch (erro) {
      mensagem = 'Não conectou rro: $erro'; //commit :)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: testar,
              child: Text('testar API'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: carregarNoticia,
              child: Text('Carregar Noticia'),
            ),

            Text(mensagem),
          ],
        ),
      ),
    );
  }
}
