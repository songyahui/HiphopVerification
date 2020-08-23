hiphop module example(in I, out O) 
/@
Require true /\ [O]
Ensure true /\ ([O I].[O])^*
@/
{
    loop {
        if( O.now ) emit I();
        yield;
        emit O();
    }
}
