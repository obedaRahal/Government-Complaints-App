// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:complaints_app/features/complaint_details/domain/use_case/add_complaint_details_use_case.dart';
// import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_cubit.dart';
// import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_cubit.dart';
// import 'package:complaints_app/features/complaint_details/presentation/view/complaint_details_view.dart';

// class ComplaintDetailsPage extends StatelessWidget {
//   final int complaintId;

//   final AddComplaintDetailsUseCase addComplaintDetailsUseCase;

  
//   final ComplaintDetailsCubit complaintDetailsCubit;

//   const ComplaintDetailsPage({
//     super.key,
//     required this.complaintId,
//     required this.addComplaintDetailsUseCase,
//     required this.complaintDetailsCubit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
       
//         BlocProvider<ComplaintDetailsCubit>.value(
//           value: complaintDetailsCubit..loadComplaintDetails(complaintId),
//         ),

        
//         BlocProvider<AddDetailsCubit>(
//           create: (_) => AddDetailsCubit(addComplaintDetailsUseCase),
//         ),
//       ],
//       child: ComplaintDetailsView(complaintId: complaintId),
//     );
//   }
// }
