import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/screens/list_post_screen.dart';
import 'package:pmsnb1/settings/styles.dart';
import 'package:pmsnb1/widgets/futures_modal.dart';
import 'package:pmsnb1/widgets/modal_add_post.dart';
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
    //final theme = Theme.of(context);

    final spaceHorizontal = SizedBox(height: 15,);

    final btnLince = ElevatedButton(
      onPressed: (){
        const primaryColour = Colors.red;
        setState(() {});
      }, 
      
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle: const TextStyle(color: Colors.green, fontSize: 20),
        fixedSize: const Size(800, 60)
      ),
      
      child: const Text('Lince'),
    );  

    final btnBlue = ElevatedButton(
      onPressed: (){
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          fontFamily: 'Georgia',

          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        );
        setState(() {});
      }, 
      
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        fixedSize: const Size(800, 60)
      ),
      
      child: const Text('Light Blue'),
    );    

    final btnRed = ElevatedButton(
      onPressed: (){
        //DynamicTheme.of(context)?.setTheme(AppThemes.LightRed);
        setState(() {});
      }, 
      
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        fixedSize: const Size(800, 60)
      ),
      
      child: const Text('Light Red'),
    );  

    final btnDark = ElevatedButton(
      onPressed: (){
        //DynamicTheme.of(context)?.setTheme(AppThemes.Dark);
        setState(() {});
      }, 
      
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        fixedSize: const Size(800, 60)
      ),
      
      child: const Text('Dark'),
    );  

    final btnEvents = ElevatedButton.icon(
      onPressed: (){
        Navigator.pushNamed(context, '/events');
      }, 
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        fixedSize: const Size(800, 60)
      ),
      icon: Icon(Icons.calendar_today), 
      label: Text('Eventos'),
    );

    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('TecBook :)'),),
      body: flags.getupdatePosts() == true ? const ListPostScreen() : const ListPostScreen(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 2, 88, 5),
        onPressed: (){
          openCustomDialog(context, null);
        }, 
        icon: Icon(Icons.add_comment),
        label: Text('Post it!')
      ),
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
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.movie),
              title: const Text(
                'API Movies',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right),
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
              //btnBlue,
              //btnRed,
              //btnDark,
              btnLince,
              spaceHorizontal,
              btnEvents
          ],
        ),
      ),
    );
  }

}



