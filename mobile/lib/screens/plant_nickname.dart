import 'package:flutter/material.dart';

class PlantNickname extends StatefulWidget {
  const PlantNickname({
    super.key,
    required this.plantNickname,
  });
  final String plantNickname;

  @override
  State<PlantNickname> createState() => _PlantNicknameState();
}

class _PlantNicknameState extends State<PlantNickname> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.plantNickname;
    _controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAF7),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Give a little nickname",
              style: TextStyle(
                color: Color(0xff293B1C),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "for your plant",
              style: TextStyle(
                color: Color(0xff293B1C),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // add bold
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Plant Name",
                    style: TextStyle(
                      color: Color(0xff6A6A6A),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${_controller.text.length}/20",
                    style: const TextStyle(
                      color: Color(0xff6A6A6A),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                onEditingComplete: (() => {
                      if (_controller.text.isNotEmpty &&
                          _controller.text.length <= 20)
                        {
                          Navigator.of(context).pop(),
                        }
                    }),
                controller: _controller,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 20) {
                    return 'Enter a valid nickname';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  suffixIcon: _controller.text.isEmpty
                      ? null // Show nothing if the text field is empty
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => {
                            setState(
                              () {
                                _controller.clear();
                              },
                            ),
                          },
                        ),
                ), // Show the clear button if the text field has something
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scaleX: -1,
                    child: const Icon(
                      Icons.refresh,
                      size: 24,
                      color: Color(0xff8BA07E),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Generate one for me",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8BA07E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
