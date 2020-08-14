int itemCount = 0;

hiphop module producer(){
  loop{

    item = produceItem();

    await count(attempts, NotFull);
  
    putItemIntoBuffer(item);
        
    itemCount = itemCount + 1;

    if (itemCount == 1) { emit NotEmp;}
  }
}

hiphop module consumer(){
  loop{

    await NotEmp;

    item = removeItemFromBuffer();

    itemCount = itemCount - 1;

    if (itemCount == BUFFER_SIZE - 1) {emit NotFull;}

    consumeItem(item);

  }
}


hiphop module Main () {
  fork{
    run producer();
  }
  par {
    run consumer();
  }
}