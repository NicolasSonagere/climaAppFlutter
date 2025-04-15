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
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Seus dados foram enviados com sucesso!')),
    );

    temperaturaController.clear();
    umidadeController.clear();
    chuvaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // Garante que o fundo cobre a tela inteira
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.blueAccent],
            ),
            image: DecorationImage(
              image: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/016/586/629/small_2x/twinkle-star-pattern-for-photo-effect-and-overlay-abstract-blurry-star-light-texture-for-background-png.png',
              ),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cadastrar Clima',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                _buildTextField(temperaturaController, 'Insira a Temperatura'),
                SizedBox(height: 20),
                _buildTextField(umidadeController, 'Insira a Umidade'),
                SizedBox(height: 20),
                _buildTextField(chuvaController, 'Insira a Chance de Chuva'),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: postClima,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Enviar', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
      ),
    );
  }
}
