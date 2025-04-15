import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostClimaScreen extends StatefulWidget {
  const PostClimaScreen({super.key});

  @override
  State<PostClimaScreen> createState() => _PostClimaScreenState();
}

class _PostClimaScreenState extends State<PostClimaScreen> {
  final TextEditingController temperaturaController = TextEditingController();
  final TextEditingController umidadeController = TextEditingController();
  final TextEditingController chuvaController = TextEditingController();

  Future<void> postClima() async {
    final double temperatura = double.parse(temperaturaController.text);
    final double umidade = double.parse(umidadeController.text);
    final double chuva = double.parse(chuvaController.text);

    await FirebaseFirestore.instance.collection('Hortolandia').add({
      'temperatura': temperatura,
      'umidade': umidade,
      'chuva': chuva,
      'timestamp': Timestamp.now(),
    }
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Seus dados foram enviados com sucesso!'))
    );

    temperaturaController.clear();
    umidadeController.clear();
    chuvaController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Tela de post'),
    ),
    body: Column(
      children: [
        TextField(
          controller: temperaturaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Insira a Temperatura',
          ),
        ),

        TextField(
          controller: umidadeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Insira a Umidade',)
        ),

        TextField(
          controller: chuvaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Insira a Chance de Chuva',)
        ),
        ElevatedButton(onPressed: postClima, child: Text('Enviar'))
      ],
    ));
  }
}
