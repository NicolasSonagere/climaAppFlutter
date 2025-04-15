import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaDados extends StatefulWidget {
  const TelaDados({super.key});

  @override
  State<TelaDados> createState() => _TelaDadosState();
}

class _TelaDadosState extends State<TelaDados> {
  double temperatura = 0.0;
  double umidade = 0.0;
  double chuva = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    FirebaseFirestore.instance
        .collection('Hortolandia')
        .snapshots()
        .listen((snapshot) {
      var data = snapshot.docs.last.data();
      setState(() {
        temperatura = (data['temperatura'] ?? 0).toDouble();
        umidade = (data['umidade'] ?? 0).toDouble();
        chuva = (data['chuva'] ?? 0).toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.blueAccent],
          ),
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/016/586/629/small_2x/twinkle-star-pattern-for-photo-effect-and-overlay-abstract-blurry-star-light-texture-for-background-png.png',
            ),
            fit: BoxFit.fitWidth, // Ajustado para cobrir toda a área sem distorções
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Temperatura: $temperatura°C',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Umidade: $umidade%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Probabilidade de Chuva: $chuva%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}