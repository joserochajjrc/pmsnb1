import 'package:flutter/material.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/responsive.dart';
import 'package:pmsnb1/screens/list_event_screen.dart';
import 'package:pmsnb1/screens/list_post_screen.dart';
import 'package:pmsnb1/widgets/futures_modal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class eventsScreen extends StatefulWidget {
  const eventsScreen({super.key});

  @override
  State<eventsScreen> createState() => _eventsScreenState();
}

class _eventsScreenState extends State<eventsScreen> {
  @override
  Widget build(BuildContext context) {

    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
       resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            child: responsive(
              mobile: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white, 
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.single,
                        showActionButtons: true,
                        confirmText: 'ADD',
                        onSubmit: (DateTime){
                          print(DateTime);
                          openEventsDialog(context, null, DateTime.toString());
                        },
                        cancelText: '',
                      ) 
                    )        
                  ),
                  Expanded(
                    child: Scaffold(
                      body: flags.getupdatePosts() == true ? ListPostScreen() : ListPostScreen(),
                    )
                  ),
                ],
              ), 
              desktop: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white, 
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.single,
                        showActionButtons: true,
                        confirmText: 'ADD',
                        onSubmit: (DateTime){
                          print(DateTime);
                          openEventsDialog(context, null, DateTime.toString());
                        },
                        cancelText: '',
                      ) 
                    )
                  ),
                  Expanded(
                    child: Scaffold(
                      body: flags.getupdatePosts() == true ? ListPostScreen() : ListPostScreen(),
                    )
                  ),
                ],
              ),
              tablet: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white, 
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.single,
                        showActionButtons: true,
                        confirmText: 'ADD',
                        onSubmit: (DateTime){
                          print(DateTime);
                          openEventsDialog(context, null, DateTime.toString());
                        },
                        cancelText: '',
                      ) 
                    )
                  ),
                  Expanded(
                    child: Scaffold(
                      body: flags.getupdatePosts() == true ? ListPostScreen() : ListPostScreen(),
                    )
                  ),
                ],
              ),
              ),
          ),
        ],
      ),
    );
  }
}
