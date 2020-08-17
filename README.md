# Automated Temporal Verification for HipHop.js

HipHop.js [7] is a synchronous reactive language that adds synchronous concurrency and preemption to JavaScript, inspired from Esterel and built on top of Hop.js. HipHop.js simplifies the program- ming of non-trivial temporal behaviors as found in complex web inter- faces or IoT controllers and the cooperation between synchronous and asynchronous activities. In this paper, we present the first solution to ensure temporal properties for HipHop.js programs via a Hoare-style verifier and a term rewriting system (T.r.s) on synced Effects. The main contribution is the forward verification able to accumulate effects from the source code, check the temporal specifications annotated in precon- dition and postcondition. We represent temporal properties in synced effects, an extended regular language, and soundly and efficiently solve the language inclusions using a back-end T.r.s. We prototype this logic on top of the HIP/SLEEK system and show our method’s feasibility using a number of case studies.

1. conjunction and disjunction in the time instant [S1/\S2 \/ S3]

2. What are the interesting: Conditional deadline and the syncronized signals

3. How does Esterel deal with when deadline is violated. Exceptions? 
Is deadlock important for hiphop.js 
How often then occur. 

4. Write specification for the examples. 

5. Design a language, simplified hiphop 

6. Program anylysis. 



