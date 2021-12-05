import 'package:estdict/app/modify_word/create_word_page.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';

import 'home_page_block.dart';

class CreateWordButtons extends StatelessWidget {
  const CreateWordButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var partsOfSpeech = PartOfSpeech.values;
    return HomePageBlock(
        child: Row(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a new word',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 5,
                ),
                itemCount: partsOfSpeech.length,
                itemBuilder: (context, index) => ActionChip(
                    label: Text(partsOfSpeech[index].name),
                    onPressed: () =>
                        openWordCreationDialog(context, partsOfSpeech[index])),
              ),
            )
          ],
        ))
      ],
    ));
  }

  openWordCreationDialog(BuildContext context, PartOfSpeech partOfSpeech) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateWordPage(partOfSpeech: partOfSpeech)));
  }
}
