hiphop module prg(in I, out O ) 
/@
Require true 
Ensure n <= 3 /\ I ∉ X /\ (X^n . [I? O])^*
@/
{
    loop {
        await count( 3, I.now );
        emit O();
    }
}
