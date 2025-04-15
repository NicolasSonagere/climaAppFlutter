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
      body: StreamBuilder<QuerySnapshot>
        (stream: FirebaseFirestore.instance.collection('Hortolandia').snapshots(),
          builder: (context,snapshots){
            if(snapshots.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
          }
          if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
            return Center(
              child: Text('Nenhum dado encontrado'),
            );
          }
          var dataList = snapshots.data!.docs;

          return ListView.builder(itemCount: dataList.length,
          itemBuilder: (context,index){
            var data = dataList[index].data() as Map<String, dynamic>;

            double temperatura = (data['temperatura'] ?? 0.0).toDouble();
            double umidade = (data['umidade'] ?? 0.0).toDouble();
            double chuva = (data['chuva'] ?? 0.0).toDouble();
            Timestamp timestamp = data['timestamp'];
            final datetime = timestamp.toDate();
            String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(datetime);


            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Temperatura: $temperatura ºC   -  $dataFormatada'),
                subtitle: Text('Umidade $umidade %   -   Probabilidade de chuva $chuva %'),
                trailing: Icon(Icons.thermostat),
              )
            );
          },
          );

        })
    );
  }
}
