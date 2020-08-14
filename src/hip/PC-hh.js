int itemCount = 0;

procedure producer :

LOOP:
  item = produceItem();

  AWAIT NotFull;
  
  putItemIntoBuffer(item);
        
  itemCount = itemCount + 1;

  if (itemCount == 1) 
    {
      EMIT NOTEMP;
    }
;

procedure consumer() :
  LOOP:

    AWAIT NOTEMP ;

    item = removeItemFromBuffer();
    itemCount = itemCount - 1;

    if (itemCount == BUFFER_SIZE - 1) 
    {
      EMIT NotFull;
    }

    consumeItem(item);
;