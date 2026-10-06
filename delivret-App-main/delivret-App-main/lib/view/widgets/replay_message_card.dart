import 'package:flutter/material.dart';

class ReplayMessageCard extends StatelessWidget {
  final String msg;
  final String time;
  const ReplayMessageCard({super.key, required this.msg, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  msg,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
