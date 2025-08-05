import 'package:cazuela_movil/features/auth/domain/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_metricas_entity.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            DashboardMetricasEntity metricas = state.metricas;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Total Ventas'),
                    trailing: Text('${metricas.totalVentas}'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Total Pedidos'),
                    trailing: Text('${metricas.totalPedidos}'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Ingresos'),
                    trailing: Text('\$${metricas.ingresos.toStringAsFixed(2)}'),
                  ),
                ),
              ],
            );
          } else if (state is DashboardError) {
            return Center(child: Text('Error: ${state.mensaje}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/dashboard_metricas_entity.dart';
// import '../bloc/dashboard_bloc.dart';
// import '../bloc/dashboard_event.dart';
// import '../bloc/dashboard_state.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.of<DashboardBloc>(context).state is! DashboardLoaded
//         ? const Center(child: CircularProgressIndicator())
//         : Scaffold(
//             appBar: AppBar(title: const Text('Dashboard')),
//             body: BlocBuilder<DashboardBloc, DashboardState>(
//               builder: (context, state) {
//                 if (state is DashboardLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is DashboardLoaded) {
//                   DashboardMetricasEntity metricas = state.metricas;
//                   return ListView(
//                     padding: const EdgeInsets.all(16.0),
//                     children: [
//                       Card(
//                         child: ListTile(
//                           title: const Text('Total Ventas'),
//                           trailing: Text('${metricas.totalVentas}'),
//                         ),
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: const Text('Total Pedidos'),
//                           trailing: Text('${metricas.totalPedidos}'),
//                         ),
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: const Text('Ingresos'),
//                           trailing:
//                               Text('\$${metricas.ingresos.toStringAsFixed(2)}'),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (state is DashboardError) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           );
//   }
// }
