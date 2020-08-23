hiphop module example(in I, out O) 
/@
Require true 
Ensure true /\ ([O I].[O] \/ [].[O])^*
@/
{
    loop {
        if( O.now ) emit I();
        yield;
        emit O();
    }
}
