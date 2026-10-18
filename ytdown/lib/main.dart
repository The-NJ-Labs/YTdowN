import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YTdowN',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFEF4444),
          onPrimary: Colors.white,
          secondary: Color(0xFFFF6B6B),
          surface: Color(0xFF181818),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB71C1C),
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MyHomePage(title: 'YTdowN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _urlController = TextEditingController();

  final List<String> _formats = ['MP4 original', 'MP3 only', '1080p', '720p', '480p', '360p', '240p', '144p'];
  String _selectedFormat = 'MP4 original';


  void _handleSubmit() {
    final enteredText = _urlController.text.trim();

    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a URL')),
      );
      return;
    }

    // Do your action here (e.g. start download)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing: $enteredText as $_selectedFormat')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.smart_display_rounded,
              color: Color.fromRGBO(255, 253, 253, 1),
            ),
            const SizedBox(width: 2),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.55,
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Hugs content vertically in the center
            children: [
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'Enter video URL',
                  hintText: "https://youtu.be/dQw4w9WgXcQ?si=OPATCJ4K9UUHDLsE",
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.6,
                    ),
                  ),
                  prefixIcon: Icon(Icons.link),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _urlController.clear(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 40),
              
              DropdownButtonFormField<String>(
                initialValue: _selectedFormat,    
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedFormat = newValue;
                    });
                  }
                },  
                
                decoration: InputDecoration(
                    labelText: "Please Select Format...",
                    prefixIcon: Icon(Icons.tune_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: _formats.map((String format) {
                    return DropdownMenuItem<String>(
                      value: format,
                      child: Text(format),
                    );                  
                  }).toList(),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
