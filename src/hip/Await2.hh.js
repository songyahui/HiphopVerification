hiphop module prg(int n, in I, out O ) 
/@
Require n <=3 /\ Emp 
Ensure I ∉ X /\ (X^n . [I? O])^*
@/
{
    loop {
        await count( n, I.now );
        emit O();
    }
}
