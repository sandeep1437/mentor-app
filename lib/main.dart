import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const GWMentorApp());

enum Persona { fresher, baTester, developer }

class DocItem {
  final String id, title, category, icon, source;
  final Map<Persona, String> text;
  final Map<Persona, String> svg;
  final List<String> glossary, followUps;
  DocItem({
    required this.id, required this.title, required this.category,
    required this.icon, required this.source, required this.text,
    required this.svg, required this.glossary, required this.followUps,
  });
}

class GWMentorApp extends StatelessWidget {
  const GWMentorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GW Mentor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0F1D),
        cardColor: const Color(0xFF1E293B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          surface: Color(0xFF131D31),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  Persona _role = Persona.fresher;
  final Set<String> _bookmarks = {'gw_batch'};

  final List<DocItem> _docs = [
    DocItem(
      id: 'gw_batch',
      title: 'doWork() & Batch WorkQueues',
      category: 'Guidewire PolicyCenter',
      icon: '⚙️',
      source: 'Guidewire PolicyCenter Spec & Community',
      glossary: [
        'WorkItem: Atomic payload record processed independently',
        'Bundle: Guidewire database transaction boundary context',
      ],
      followUps: [
        'How to configure WorkQueue thread concurrency in config.xml?',
        'What is the retry policy when an unhandled exception occurs?',
      ],
      text: {
        Persona.fresher: 'Think of this like an automated kitchen. The WorkQueue is the queue of order tickets. doWork() is the line chef cooking one order at a time. If one plate is dropped, only that order is held back; the whole restaurant does not shut down!',
        Persona.baTester: 'Functional Impact: Executes mass automated policy actions (renewals, non-pay cancellations). Failed policies are flagged in the database table with error codes for manual operational triage without blocking batch completion.',
        Persona.developer: 'Technical Details: Subclass WorkQueueBase and override doWork(item: WorkItem). Each iteration wraps bundle operations via Transaction.runWithNewBundle(). Failed items transition to status=Failed and log stack trace.',
      },
      svg: {
        Persona.fresher: '<svg viewBox="0 0 400 130" xmlns="http://www.w3.org/2000/svg"><rect x="20" y="30" width="90" height="70" rx="8" fill="#1E293B" stroke="#6366F1"/><text x="65" y="70" fill="#fff" font-size="13" text-anchor="middle">Order Rack</text><line x1="110" y1="65" x2="160" y2="65" stroke="#6366F1" stroke-width="2"/><rect x="160" y="20" width="100" height="90" rx="8" fill="#1E293B" stroke="#10B981"/><text x="210" y="65" fill="#10B981" font-size="14" font-weight="bold" text-anchor="middle">doWork()</text><line x1="260" y1="65" x2="300" y2="65" stroke="#10B981" stroke-width="2"/><rect x="300" y="30" width="80" height="70" rx="8" fill="#1E293B" stroke="#F59E0B"/><text x="340" y="70" fill="#fff" font-size="13" text-anchor="middle">Complete</text></svg>',
        Persona.baTester: '<svg viewBox="0 0 400 130" xmlns="http://www.w3.org/2000/svg"><rect x="15" y="25" width="100" height="80" rx="8" fill="#1E293B" stroke="#38BDF8"/><text x="65" y="60" fill="#fff" font-size="11" text-anchor="middle">10,000 Policies</text><line x1="115" y1="65" x2="155" y2="65" stroke="#38BDF8" stroke-width="2"/><rect x="155" y="25" width="100" height="80" rx="8" fill="#1E293B" stroke="#6366F1"/><text x="205" y="65" fill="#fff" font-size="12" text-anchor="middle">Execution</text><rect x="285" y="15" width="95" height="40" rx="6" fill="#064E3B"/><text x="332" y="40" fill="#6EE7B7" font-size="11" text-anchor="middle">Success (9,990)</text><rect x="285" y="70" width="95" height="40" rx="6" fill="#7F1D1D"/><text x="332" y="95" fill="#FCA5A5" font-size="11" text-anchor="middle">Flagged (10)</text></svg>',
        Persona.developer: '<svg viewBox="0 0 400 140" xmlns="http://www.w3.org/2000/svg"><rect x="15" y="20" width="95" height="40" rx="6" fill="#312E81" stroke="#818CF8"/><text x="62" y="45" fill="#E0E7FF" font-size="11" text-anchor="middle">Thread Worker</text><rect x="150" y="20" width="100" height="40" rx="6" fill="#1E293B" stroke="#64748B"/><text x="200" y="45" fill="#E2E8F0" font-size="11" text-anchor="middle">WorkItem Lock</text><rect x="290" y="20" width="95" height="40" rx="6" fill="#064E3B" stroke="#34D399"/><text x="337" y="45" fill="#D1FAE5" font-size="11" text-anchor="middle">DB Bundle</text><line x1="62" y1="60" x2="62" y2="130" stroke="#475569" stroke-dasharray="3"/><line x1="200" y1="60" x2="200" y2="130" stroke="#475569" stroke-dasharray="3"/><line x1="337" y1="60" x2="337" y2="130" stroke="#475569" stroke-dasharray="3"/><line x1="62" y1="85" x2="195" y2="85" stroke="#818CF8" stroke-width="2"/><line x1="200" y1="110" x2="332" y2="110" stroke="#34D399" stroke-width="2"/></svg>',
      },
    ),
    DocItem(
      id: 'kafka_pubsub',
      title: 'Kafka Architecture & Partitions',
      category: 'Cloud & Distributed Systems',
      icon: '📨',
      source: 'Apache Kafka Architecture Standards',
      glossary: [
        'Partition: Ordered, immutable commit log',
        'Consumer Group: Parallel consumers scaling message consumption',
      ],
      followUps: [
        'How to maintain strict in-order processing with 10 partitions?',
        'How does Consumer Group rebalance affect latency?',
      ],
      text: {
        Persona.fresher: 'Think of Kafka like an express dispatch center. Senders drop letters into numbered mailboxes. Multiple dispatch riders grab letters simultaneously, so packages never get stuck in a single line!',
        Persona.baTester: 'Business Value: Decouples core systems so that policy, billing, and mobile push notifications talk smoothly without slowing down user transaction time.',
        Persona.developer: 'Under the Hood: Distributed commit-log with zero-copy page cache writes. Topic partitioning achieves horizontal scaling and parallel consumer thread affinity.',
      },
      svg: {
        Persona.fresher: '<svg viewBox="0 0 400 120" xmlns="http://www.w3.org/2000/svg"><rect x="20" y="30" width="80" height="60" rx="8" fill="#1E293B" stroke="#6366F1"/><text x="60" y="65" fill="#fff" font-size="12" text-anchor="middle">Producer</text><line x1="100" y1="60" x2="150" y2="60" stroke="#6366F1" stroke-width="2"/><rect x="150" y="20" width="110" height="80" rx="8" fill="#1E293B" stroke="#10B981"/><text x="205" y="55" fill="#fff" font-size="12" text-anchor="middle">Kafka Topic</text><text x="205" y="75" fill="#10B981" font-size="10" text-anchor="middle">[P0] [P1] [P2]</text><line x1="260" y1="60" x2="310" y2="60" stroke="#10B981" stroke-width="2"/><rect x="310" y="30" width="80" height="60" rx="8" fill="#1E293B" stroke="#F59E0B"/><text x="350" y="65" fill="#fff" font-size="12" text-anchor="middle">Consumer</text></svg>',
        Persona.baTester: '<svg viewBox="0 0 400 120" xmlns="http://www.w3.org/2000/svg"><rect x="20" y="20" width="90" height="35" rx="6" fill="#1E293B" stroke="#38BDF8"/><text x="65" y="42" fill="#fff" font-size="11" text-anchor="middle">Policy Issued</text><rect x="150" y="20" width="95" height="80" rx="8" fill="#1E293B" stroke="#6366F1"/><text x="197" y="65" fill="#818CF8" font-size="12" text-anchor="middle">Kafka Bus</text><rect x="290" y="20" width="90" height="35" rx="6" fill="#064E3B"/><text x="335" y="42" fill="#A7F3D0" font-size="11" text-anchor="middle">Billing Node</text></svg>',
        Persona.developer: '<svg viewBox="0 0 400 130" xmlns="http://www.w3.org/2000/svg"><rect x="15" y="35" width="80" height="60" rx="6" fill="#1E293B" stroke="#6366F1"/><text x="55" y="70" fill="#fff" font-size="11" text-anchor="middle">acks=all</text><rect x="130" y="20" width="135" height="90" rx="8" fill="#0F172A" stroke="#818CF8"/><text x="197" y="45" fill="#818CF8" font-size="11" text-anchor="middle">Partition Leader</text><rect x="145" y="60" width="105" height="20" fill="#312E81" rx="4"/><text x="197" y="75" fill="#fff" font-size="9" text-anchor="middle">Offset [0...9942]</text><rect x="300" y="35" width="85" height="60" rx="6" fill="#1E293B" stroke="#10B981"/><text x="342" y="70" fill="#D1FAE5" font-size="11" text-anchor="middle">Consumer</text></svg>',
      },
    ),
  ];

  late DocItem _activeDoc;

  @override
  void initState() {
    super.initState();
    _activeDoc = _docs.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.psychology, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('GW Mentor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<Persona>(
              value: _role,
              dropdownColor: const Color(0xFF1E293B),
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF818CF8)),
              items: const [
                DropdownMenuItem(value: Persona.fresher, child: Text('🎓 Fresher', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: Persona.baTester, child: Text('🧪 BA/Tester', style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: Persona.developer, child: Text('⚙️ Developer', style: TextStyle(fontSize: 13))),
              ],
              onChanged: (p) => setState(() => _role = p!),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: [
        _buildDocViewer(),
        _buildLearnHub(),
        _buildSavedScreen(),
      ][_tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (idx) => setState(() => _tab = idx),
        backgroundColor: const Color(0xFF111827),
        indicatorColor: const Color(0xFF6366F1).withOpacity(0.3),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.auto_stories), label: 'Docs'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.bookmark), label: 'Saved'),
        ],
      ),
    );
  }

  Widget _buildDocViewer() {
    final isBookmarked = _bookmarks.contains(_activeDoc.id);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search or ask technical questions...',
              hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF818CF8)),
              suffixIcon: const Icon(Icons.mic, color: Color(0xFF818CF8)),
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                backgroundColor: const Color(0xFF312E81),
                label: Text(_activeDoc.category, style: const TextStyle(fontSize: 11, color: Color(0xFFA5B4FC))),
              ),
              IconButton(
                icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: const Color(0xFFF59E0B)),
                onPressed: () {
                  setState(() {
                    isBookmarked ? _bookmarks.remove(_activeDoc.id) : _bookmarks.add(_activeDoc.id);
                  });
                },
              ),
            ],
          ),
          Text(_activeDoc.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildLensTab(Persona.fresher, 'Simple'),
              const SizedBox(width: 8),
              _buildLensTab(Persona.baTester, 'Functional'),
              const SizedBox(width: 8),
              _buildLensTab(Persona.developer, 'Technical'),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0F1D),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: SvgPicture.string(_activeDoc.svg[_role] ?? '', height: 130),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_activeDoc.text[_role] ?? '', style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFFE2E8F0))),
                const Divider(height: 24, color: Color(0xFF334155)),
                Text('Source: ${_activeDoc.source}', style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Glossary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          ..._activeDoc.glossary.map((g) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
            child: Text(g, style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
          )),
        ],
      ),
    );
  }

  Widget _buildLensTab(Persona p, String title) {
    final active = _role == p;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _role = p),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: active ? Colors.white : Colors.white70)),
          ),
        ),
      ),
    );
  }

  Widget _buildLearnHub() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _docs.length,
      itemBuilder: (context, idx) {
        final doc = _docs[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Text(doc.icon, style: const TextStyle(fontSize: 24)),
            title: Text(doc.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(doc.category, style: const TextStyle(color: Color(0xFF818CF8))),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              setState(() {
                _activeDoc = doc;
                _tab = 0;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildSavedScreen() {
    final saved = _docs.where((d) => _bookmarks.contains(d.id)).toList();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: saved.isEmpty
          ? const Center(child: Text('No bookmarked topics yet.'))
          : ListView.builder(
              itemCount: saved.length,
              itemBuilder: (ctx, idx) => ListTile(
                leading: Text(saved[idx].icon, style: const TextStyle(fontSize: 24)),
                title: Text(saved[idx].title),
                subtitle: Text(saved[idx].category),
                onTap: () {
                  setState(() {
                    _activeDoc = saved[idx];
                    _tab = 0;
                  });
                },
              ),
            ),
    );
  }
}