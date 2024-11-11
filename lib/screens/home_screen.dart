import 'package:flutter/material.dart';
import 'package:app_money/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final compte = auth.compte!;
    final name = auth.user!.firstName+' '+auth.user!.lastName;
    final phone = auth.user!.phone;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
          if (!auth.authenticated) {
            return ListView();
          } else {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(phone),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Accueil'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Paramètres'),
                  onTap: () {
                    // Ajouter ici la logique pour naviguer vers les paramètres
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Se déconnecter'),
                  onTap: () {
                    Provider.of<Auth>(context, listen: false)
                        .logout();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        })

      ),
      backgroundColor: Colors.teal[600],
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Colors.blue, size: 20,),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome, $name',
                                style: TextStyle(
                                  color: Colors.teal[400],
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '$phone',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            ),
                          ),
                          Text(
                            '$compte.balance $compte.currency',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      SizedBox(height: 16),
                      Text('Example ➔ Row'),
                      SizedBox(height: 16),
                      Text(
                        'Quick Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildQuickServiceCard(
                            icon: Icons.swap_horiz,
                            label: 'Transfer',
                          ),
                          _buildQuickServiceCard(
                            icon: Icons.show_chart,
                            label: 'Activity',
                          ),
                          _buildQuickServiceCard(
                            icon: Icons.account_balance,
                            label: 'My Bank',
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildTransactionCard(
                        title: 'Go Far Rewards',
                        amount: '\$50.00',
                        subtitle1: 'Income',
                        subtitle2: 'Hello World',
                      ),
                      _buildTransactionCard(
                        title: 'Go Far Rewards',
                        amount: '\$50.00',
                        subtitle1: 'Income',
                        subtitle2: 'Hello World',
                      ),
                      _buildTransactionCard(
                        title: 'Go Far Rewards',
                        amount: '\$50.00',
                        subtitle1: 'Income',
                        subtitle2: 'Hello World',
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

Widget _buildInfoCard({
  required String title,
  required String amount,
  required String subtitle1,
  required String subtitle2,
  required String subtitle3,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.teal[400],
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subtitle1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        Text(
          subtitle2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subtitle3,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickServiceCard({
  required IconData icon,
  required String label,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransactionCard({
  required String title,
  required String amount,
  required String subtitle1,
  required String subtitle2,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.only(top: 8),
    child: Row(
      children: [
        Icon(
          Icons.attach_money,
          color: Colors.teal[400],
          size: 24,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle1,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle2,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
