hiphop module prg(in A, in B ) 
/@
Require true 
Ensure A ∉ X /\ X^n.[A] \/ B ∉ Y /\ Y^n.[B] 
@/
{
EXIT: fork {
        await( A.now );
        break EXIT;
      } par {
        await( B.now );
        break EXIT;
      }
}
