hiphop module prg( out J ) 
/@
Require true 
Ensure true /\ [].[I J]
@/
{
    signal I;
    fork {
        yield; emit I();   // [].[I]
    } par {
        await( I.now );   
        emit J();   // I ∉ X /\ X^n. [I? J] 
    }
}

