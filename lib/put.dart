import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PutClima extends StatefulWidget {
  final String documentId;
  final double temperaturaInicial;
  final double umidadeInicial;
  final double chuvaInicial;

  const PutClima({super.key, required this.documentId, required this.temperaturaInicial,
    required this.umidadeInicial, required this.chuvaInicial});

  @override
  State<PutClima> createState() => _PutClimaState();
}

class _PutClimaState extends State<PutClima> {
  TextEditingController temperaturaController = TextEditingController();
  TextEditingController umidadeController = TextEditingController();
  TextEditingController chuvaController = TextEditingController();

  Future<void> putClima() async {
    double? temperatura = double.tryParse(temperaturaController.text);
    double? umidade = double.tryParse(umidadeController.text);
    double? chuva = double.tryParse(chuvaController.text);

    await FirebaseFirestore.instance.collection('Hortolandia').doc(widget.documentId).set({
      'temperatura': temperatura,
      'umidade': umidade,
      'chuva': chuva,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
