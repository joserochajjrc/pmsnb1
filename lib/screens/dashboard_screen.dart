import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/settings/styles.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkThemeEnable = false;

  @override
  Widget build(BuildContext context) {

    

    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('TecBook :)'),),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://raw.githubusercontent.com/obliviate-dan/Login-Form/master/img/avatar.png'),
              ),
              accountName: Text('José Juan Rocha Cisneros'), 
              accountEmail: Text('19031005@itcelaya.edu.mx')
            ),
            DayNightSwitcher(
                isDarkModeEnabled: isDarkThemeEnable,
                onStateChanged: ((isDarkModeEnabled) {
                  isDarkModeEnabled 
                    ? theme.setthemeData(StylesApp.darkTheme(context))
                    : theme.setthemeData(StylesApp.lightTheme(context));

                  
                  isDarkThemeEnable = isDarkModeEnabled;
                  setState(() {
                    
                  });

                }),
              ),
          ],
        ),
      ),
    );
  }
}
