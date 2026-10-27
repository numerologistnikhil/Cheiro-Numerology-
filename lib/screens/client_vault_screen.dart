import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../core/app.dart';
import '../core/local_vault.dart';
import '../core/numerology_engine.dart';
import 'analysis_card.dart';
import 'ui_kit.dart';

class ClientVaultScreen extends StatefulWidget {
  const ClientVaultScreen({super.key});

  @override
  State<ClientVaultScreen> createState() => _ClientVaultScreenState();
}

class _ClientVaultScreenState extends State<ClientVaultScreen> {
  final LocalVault _vault = const LocalVault();
  List<ClientRecord> _clients = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await _vault.loadClients();
      if (!mounted) return;
      setState(() {
        _clients = list;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not open the vault on this phone.';
      });
    }
  }

  Future<void> _persist(List<ClientRecord> list) async {
    try {
      await _vault.saveClients(list);
      if (!mounted) return;
      setState(() {
        _clients = list;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Could not save. Nothing was changed.');
    }
  }

  Future<void> _add() async {
    final nameC = TextEditingController();
    final notesC = TextEditingController();
    DateTime? dob;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          title: const Text('New client'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameC,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 12),
                DateField(usesProfile: false,

                  label: 'Date of birth',
                  value: dob,
                  onChanged: (d) => setDialog(() => dob = d),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesC,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    final name = nameC.text.trim();
    if (ok == true && name.isNotEmpty) {
      final record = ClientRecord(
        id: const Uuid().v4(),
        name: name,
        dob: dob,
        notes: notesC.text.trim(),
      );
      await _persist([..._clients, record]);
    }
  }

  Future<void> _delete(ClientRecord c) async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete client?'),
        content: Text('${c.name} will be removed from this phone permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (sure == true) {
      await _persist(_clients.where((x) => x.id != c.id).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Vault')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _add,
        backgroundColor: AnkdharaColors.gold,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Client'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 90),
          children: [
            const Note(
              'Client details are encrypted on this phone (AES-256-GCM). The '
              'key stays in Android secure storage and nothing is uploaded. '
              'There is no cloud backup: if you uninstall the app or clear '
              'its data, the records are lost. A fingerprint or PIN lock '
              'will be added later.',
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 14),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_clients.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(child: Text('No clients saved yet.')),
              )
            else
              for (final c in _clients)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GoldCard(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      title: Text(
                        c.name,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        c.dob == null ? 'No birth date' : formatDate(c.dob!),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(c),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ClientDetailScreen(client: c),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class ClientDetailScreen extends StatelessWidget {
  final ClientRecord client;
  const ClientDetailScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final dob = client.dob;
    final nameResult = NumerologyEngine.name(client.name);
    return PageShell(
      title: client.name,
      children: [
        if (client.notes.isNotEmpty)
          GoldCard(child: Text(client.notes, style: const TextStyle(height: 1.5))),
        const SizedBox(height: 14),
        if (nameResult.total > 0)
          AnalysisCard(title: 'Name Analysis', result: nameResult),
        if (dob != null)
          AnalysisCard(
            title: 'Date of Birth Analysis',
            result: NumerologyEngine.date(dob),
          ),
      ],
    );
  }
}
