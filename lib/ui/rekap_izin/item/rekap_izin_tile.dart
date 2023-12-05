import 'package:deka_mobile/extensions/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/response/rekap_izin_model.dart';

class RekapIzinTile extends StatelessWidget {
  final RekapIzinModel? rekapIzin;
  final bool? isRemovable;
  final void Function(RekapIzinModel rekapIzin)? onRemove;
  final void Function(RekapIzinModel rekapIzin)? onArticlePressed;

  const RekapIzinTile({
    Key? key,
    this.rekapIzin,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 2,
            child: Row(
              children: [
                _buildTitleAndDescription(),
              ],
            ),
          )),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#${rekapIzin?.code}",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const Divider(
              color: Colors.black38,
            ),
            Text(
              (rekapIzin?.reasonName ?? "").toString().toTitleCase(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.teal,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(rekapIzin?.startDate ?? "")),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                ),
                const Expanded(
                  flex: 1,
                  child: Text("s.d",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(rekapIzin?.endDate ?? "")),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              rekapIzin?.descApproval ?? "",
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.amber,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(rekapIzin!);
    }
  }
}
