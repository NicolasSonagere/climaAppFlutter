import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PutClima extends StatefulWidget {
  final String documentId;
  final double temperaturaInicial;
  final double umidadeInicial;
  final double chuvaInicial;

  const PutClima({
    super.key,
    required this.documentId,
    required this.temperaturaInicial,
    required this.umidadeInicial,
    required this.chuvaInicial,
  });

  @override
  State<PutClima> createState() => _PutClimaState();
}

class _PutClimaState extends State<PutClima> {
  late TextEditingController temperaturaController;
  late TextEditingController umidadeController;
  late TextEditingController chuvaController;

  @override
  void initState() {
    super.initState();
    temperaturaController = TextEditingController(text: widget.temperaturaInicial.toString());
    umidadeController = TextEditingController(text: widget.umidadeInicial.toString());
    chuvaController = TextEditingController(text: widget.chuvaInicial.toString());
  }

  Future<void> putClima() async {
    double? temperatura = double.tryParse(temperaturaController.text);
    double? umidade = double.tryParse(umidadeController.text);
    double? chuva = double.tryParse(chuvaController.text);

    await FirebaseFirestore.instance.collection('Hortolandia').doc(widget.documentId).set({
      'temperatura': temperatura,
      'umidade': umidade,
      'chuva': chuva,
      'timestamp': Timestamp.now(),
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dados atualizados com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
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
          child: Container(
            color: Colors.black.withOpacity(0.6),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Atualizar Clima',
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
                    onPressed: putClima,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Atualizar', style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ],
              ),
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
