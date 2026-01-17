import 'package:flutter/material.dart';

class MatchComposerPage extends StatelessWidget {
  const MatchComposerPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: SizedBox.shrink());
}

class MatchComposerArgs {
  const MatchComposerArgs({this.prefillTeamId, this.prefillFieldId});

  final int? prefillTeamId;
  final int? prefillFieldId;
}
