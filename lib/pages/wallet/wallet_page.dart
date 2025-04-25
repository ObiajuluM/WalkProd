import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Connect Wallet",
          style: TextStyle(
            // color:Theme.of(context).brightness == Brightness.light
            //     ? Color.fromARGB(255, 255, 255, 255)
            //     : const Color(0xFF67A1C5),
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),

      ///
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Please enter your testnet wallet address.",
              // "Please enter your testnet wallet address. Ensure that the address is funded, as unfunded addresses will be flagged as bot addresses.\n Note that this address cannot be changed once it has been added.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: addressController,

              //TODO: to check if address is valid evm address
              onChanged: null,
              decoration: InputDecoration(
                hintText: "address...",
                // hintStyle:
                //     TextStyle(color: Theme.of(context).colorScheme.primary),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFF67A1C5)
                        : const Color(0xFF394861),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          ///
          ElevatedButton(
            onPressed: () {},
            // style: ElevatedButton.styleFrom(
            //   shape: CircleBorder(),
            // ),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
