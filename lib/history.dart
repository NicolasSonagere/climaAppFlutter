import 'package:climaapp/put.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricoClima extends StatefulWidget {
  const HistoricoClima({super.key});

  @override
  State<HistoricoClima> createState() => _HistoricoClimaState();
}

class _HistoricoClimaState extends State<HistoricoClima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Hortolandia').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
              return Center(child: Text('Nenhum dado encontrado', style: TextStyle(color: Colors.white)));
            }

            var dataList = snapshots.data!.docs;

            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                var data = dataList[index].data() as Map<String, dynamic>;

                double temperatura = (data['temperatura'] ?? 0.0).toDouble();
                double umidade = (data['umidade'] ?? 0.0).toDouble();
                double chuva = (data['chuva'] ?? 0.0).toDouble();
                var doc = dataList[index];
                Timestamp timestamp = data['timestamp'];
                final datetime = timestamp.toDate();
                String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(datetime);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        PutClima(
                            documentId: doc.id,
                            temperaturaInicial: temperatura,
                            umidadeInicial: umidade,
                            chuvaInicial: chuva))
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        'Temperatura: $temperatura ºC - $dataFormatada',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Umidade: $umidade% - Chuva: $chuva%'),
                      leading: Icon(Icons.thermostat),
                      trailing: IconButton(onPressed: () async {
                        await FirebaseFirestore.instance.collection('Hortolandia').doc(doc.id).delete();
                      },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
