import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../widgets/omni_glass_container.dart';
import '../widgets/adaptive_text.dart';

class NotificationService {
  static void showMenu({
    required BuildContext context,
    required List<AppNotification> notifications,
    required Function(AppNotification) onRead,
    required Function(int) onDelete,
  }) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Material(
              color: Colors.transparent,
              child: OmniGlassContainer(
                borderRadius: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: AdaptiveText("Notifications", fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    Flexible(
                      child: notifications.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(40),
                              child: AdaptiveText("No notifications"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final item = notifications[index];
                                return ListTile(
                                  leading: Icon(Icons.circle, size: 10, 
                                    color: item.isRead ? Colors.transparent : Colors.blueAccent),
                                  title: AdaptiveText(item.title, 
                                    fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.close, size: 16, color: Colors.redAccent),
                                    onPressed: () {
                                      onDelete(index);
                                      setDialogState(() {});
                                    },
                                  ),
                                  onTap: () {
                                    onRead(item);
                                    setDialogState(() {});
                                    Navigator.pop(context);
                                    showDetail(context: context, item: item);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showDetail({required BuildContext context, required AppNotification item}) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: OmniGlassContainer(
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline_rounded, size: 48, color: Colors.blueAccent),
                const SizedBox(height: 16),
                AdaptiveText(item.title, fontSize: 20, fontWeight: FontWeight.bold),
                const SizedBox(height: 12),
                AdaptiveText(item.body, textAlign: TextAlign.center),
                const Divider(height: 30, color: Colors.white12),
                AdaptiveText(item.footer, fontSize: 12),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const AdaptiveText("Got it", fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}