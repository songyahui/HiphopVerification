hiphop module prg( in A, in B, in R, out O ) {
  do {
     fork {
        await now( A );
     } par {
        await now( B );
     }
     emit O();
  } every( now( R ) )
}