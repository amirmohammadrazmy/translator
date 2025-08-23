import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DailyQuoteCard extends StatefulWidget {
  const DailyQuoteCard({Key? key}) : super(key: key);

  @override
  State<DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends State<DailyQuoteCard> {
  late String _currentQuote;
  late String _currentAuthor;

  @override
  void initState() {
    super.initState();
    _setDailyQuote();
  }

  void _setDailyQuote() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final quoteIndex = dayOfYear % _persianQuotes.length;
    
    setState(() {
      _currentQuote = _persianQuotes[quoteIndex]['quote']!;
      _currentAuthor = _persianQuotes[quoteIndex]['author']!;
    });
  }

  static const List<Map<String, String>> _persianQuotes = [
    {
      'quote': 'زندگی زیباست، زیبایی را در آن ببین',
      'author': 'سعدی'
    },
    {
      'quote': 'دانش آموختن، نور است',
      'author': 'امام علی'
    },
    {
      'quote': 'صبر کلید رستگاری است',
      'author': 'مولوی'
    },
    {
      'quote': 'هر که بامش بیش، برفش بیشتر',
      'author': 'سعدی'
    },
    {
      'quote': 'خداوند در کنار صابران است',
      'author': 'قرآن کریم'
    },
    {
      'quote': 'علم بهتر از ثروت است',
      'author': 'امام علی'
    },
    {
      'quote': 'دوستی و محبت، اساس زندگی است',
      'author': 'حافظ'
    },
    {
      'quote': 'امیدوار باش، خداوند مهربان است',
      'author': 'مولوی'
    },
    {
      'quote': 'سعی و تلاش، کلید موفقیت است',
      'author': 'سعدی'
    },
    {
      'quote': 'خوبی کن و در رودخانه بینداز',
      'author': 'سعدی'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          gradient: LinearGradient(
            colors: AppTheme.secondaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.quote,
                  color: Colors.white.withOpacity(0.8),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'نقل قول روزانه',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Vazir',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _currentQuote,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Vazir',
                height: 1.4,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '- $_currentAuthor',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Vazir',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 