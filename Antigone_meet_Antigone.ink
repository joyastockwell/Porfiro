There's a bowl of candy that you can't stop staring at. The chemistry department's front desk guy put it on the shelf behind his desk before leaving for vacation. You have been leaning against his desk for a while.

 + Keep staring at the candy -> stare1
 + Look for food elsewhere -> lib

==lib==

You go to the technical library, which is right outside the chemistry department.

You walk around the whole place. You just end up back where you started, but hungrier.

+ Stare at the candy -> stare1
+ Look for food elsewhere -> phy

==phy==

You walk to the physics department. Their door is locked. You stare wistfully at the schedules pinned to the door.

None of them are edible.

+ Go back to the chemistry department and stare at the candy -> stare2
+ Look for food elsewhere -> door

==stare1==

You lean against the desk and daydream about stuffing face.

 + Keep staring at the candy -> stare2
 + Look for food elsewhere -> phy

==stare2==

In your mind, you are lifting the bowl of candy over your head and turning it upside down.

 + Keep staring at the candy -> stare3
 + Look for food elsewhere -> door
 
 ==door==
 
 You go to the door out of the university. But you're not ready to give up on this place yet, and there's nowhere else interesting nearby anyway.
 
 + Go back to the chemistry department and stare at the candy -> stare3
 + Look for food elsewhere -> bath

==stare3==

You are currently enjoying an imaginary candy rain.

 + Keep staring at the candy -> stare4
 + Look for food elsewhere -> bath
 
 ==bath==
 
 You wander to the bathroom. You're not really sure what you were hoping to find here. You check under the sink for anything interesting.
 
 + Go back to the chemistry department and stare at the candy -> stare4
 + Look for food elsewhere -> bath2
 
 ==bath2==
 
 You wander out of the bathroom and stare at the drinking fountain and the bathroom door. You take a sip of tepid water from the fountain. It makes you feel demotivated.
 
  + Go back to the chemistry department and stare at the candy -> stare4
  + Look for food elsewhere -> bath3
 
 ==bath3==
 
The halls are empty and demotivation seeps into your bones.

  + Go back to the chemistry department and stare at the candy -> stare4
 
 ==stare4==
 
 You close your eyes, slump forward across the chemistry guy's desk, and reach for the candy. You will never reach it. But you dream...
 
 Woman's voice: What are you doing?
 
 You: Augh!
 
 + Run away -> run 
 + Confess -> fess 
 
 ==run==
 
You take off into the library and start dodging around the tables.

Her: Kid, what the @$%?! Did you take something?

You stumble over a table and she catches up.

Her: Well, did you?

You: No I just...wanted the candy.

Her: Why did you run?

You: You startled me. And I didn't know if I was supposed to be there.

She smiles like you might be crazy and makes room for you to stand. You do so.

Her: Come on, kid, I'll get you some.

You both go back to the chemistry department.

-> candy

/*==ans==



 ==run2==

You sprint for the door. But when you get there, it's locked.

Her: Look, kid, you have to come back. If you took anything, I need to know.

+ Answer -> ans2 
+ Hide -> hide

==hide==

You sneak back to the chemistry department and stare at the candy again. You know it is a dumb hiding place but you can't resist.

Part of you tries to justify it because maybe this is the place she least suspects or something.

TODO*/

==fess==

You: Oh, hi. I...wanted the candy...

Her: You want it that badly?

You (sheepish): Yeah.

->candy

==candy==

Her: Kid, you're not going to bankrupt anybody by taking it.

You: Oh. I hadn't thought of that.

Her: I figured.

She smiles and gets you the candy jar. You open it and set it between you. She sits on the desk and you join her. You start eating.

Her: So, kid, what brings you here?

You: I'm going to be a magician!

She throws her head back and laughs. Then she looks at you and laughs again.

Her: Oh! You're serious! That's wonderful, kid. But you're going to need something to do in the meantime.

She picks up a fistful of candy.

+ Judge her silently -> judge 

+ Just take more candy -> candy2

==judge==

You roll your eyes when she's looking at her fist.

-> candy3

==candy2==

You take a similarly large fistful and cram half of it into your mouth.

->candy3

==candy3==

You: I guess I hadn't thought that far.

She looks at you as hard as one can with bulging cheeks.

Her: You're not a student, are you?

You: I'm fifteen.

Her: @%$, kid! What are you doing here?

You: I ran away to be a magician. There's a library here.

Her: And no food.

You: There is when it's not break.

She smiles conspiratorially.

Her: Fair point.

You sit in silence and eat candy together for a while.

Her: You know, kid, I like you. Let me grab something.

She pokes around behind the desk for a minute, then jumps up.

Her: Here we go. The chem department needs a grader. Can you fog up a mirror, kid?

You: Yes?

Her: Great, then you're qualified. It's not exciting work, but it needs doing. And it's honorable work. University can't function without it.

She hands you the stack of papers.

+ Pick it up -> take 

+ Read them -> read

==read==

You see that it asks for a lot of info you don't have.

You: I don't think I can fill all the blanks.

Her: Oh, don't worry about it. Just write what you can.

She smiles.

-> ending

==take==

You take it.

-> ending

==ending==

Her: You'd be working for me. Again, I like you, kid. I hope you'll do it.

You: Your name is Antigone?

Her: Yeah. And you are?

You: Porfiro.

She smiles and picks up the candy bowl.

Her: Well, Porfiro, leave it on the desk when you're done and show up in the library on Monday. Nine o'clock?

You: Okay.

She smiles and waves. And leaves with the candy bowl.

    -> END