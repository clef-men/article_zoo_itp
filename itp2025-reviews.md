ITP 2025 Paper #18 Reviews and Comments
===========================================================================
Paper #18 Zoo: A framework for the verification of concurrent OCaml 5
programs using separation logic


Review #18A
===========================================================================

Overall merit
-------------
3. Weak accept

Reviewer expertise
------------------
2. Some familiarity

Review
------
## Summary

This paper introduces Zoo, a framework designed to verify concurrent OCaml
programs.  Zoo consists of ZooLang (a core calculus designed to model concurrent
OCaml programs faithfully), and `ocaml2zoo`, a translator from OCaml programs to
ZooLang programs.  Zoo leverages the Iris framework for higher-order concurrent
separation logic, and the Diaframe proof automation framework.

Verification efforts using Zoo (alongside general investigation) expose some
potential shortcomings of OCaml when writing concurrent programs.  The author(s)
identify imprecision in the notion of physical equality, and propose a more
precise definition and the introduction of "generative constructors" (these do
not participate in any representation (un)sharing).  The author(s) also propose
extensions to OCaml: atomic record fields and arrays.


## Overall

This paper seems to contain considerable technical contributions, boasting:
- a applicable verification framework for a real-world language;
- that has been applied to several examples;
- and has driven proposals for language changes.

However, this leave the author(s) with a large amount of material to present in
the space, and this makes the paper not so easy to follow - the reader is left
with various outstanding questions.  Much of the space in the paper is devoted
to OCaml as a language (and proposals for its changes), rather than material
specific to verification and interactive theorem proving.


## Major comments/questions

**Presentation.**
There is a lot of material to present in the space.  At various points, I am
left wishing for more detail/intuition/examples - and without supplementary
material or appendices this is tricky.  For example:
- 211-212: I'm a little unclear on the distinction between `in_type` and `in
  custom ...` - what do they each do, and why are both necessary?
- 226: I'm afraid I'm completely lost here. What are `ValRecs` and `AsValRecs'`?
  What does the boilerplate actually do here?
- 255: without further explanation, I'm not sure I understand how one would use
  these in OCaml.  The prophecy variables are otherwise not really
  mentioned/used in the paper.

**Light on verification/ITP material.**
A great deal of the paper is devoted to intricacies of OCaml, e.g. its
semantics, memory representation, and optimisations.  In particular:
- Very little is said about the examples that have been verified, other than
  showing a very high-level theorem statement.
- Proof automation via Diaframe is mentioned briefly, but no details on this are
  given.
- Meanwhile several pages explore proposed language extensions, and OCaml's
  notion of physical equality.  To be clear, I found this interesting!  I just
  wonder if this is the most appropriate (balance of) content for ITP.

**ZooLang.**
I had a few unanswered questions about ZooLang itself (§3) - some details which
felt glossed over, and some design choices that it seems the author(s) did not
have space to explain.
- Figure 1:
  - what are `<>` binder forms?
  - `fun`/`rec`/`let`/`letrec` forms:
    - Why distinguish anonymous and non-anonymous bindings here?
    - Similarly, the distinction between top-level and expression-level seems
      unclear to me.
    - Why have both `let: x := e1 in e2` and `let: x1, ..., xn := e1 in e2`
      forms? Is the first not a special case of the second?
    - **NB:** I can see the paragraph starting line 165 about orthogonality vs.
      memory representations, but it does not seem obvious to me how this
      impacts the above.
    - What is the `let: 'C x1 ... xn := e1 in e2` form?
- Non-anonymous binding forms do not seem to be mentioned in corresponding
  prose.
- I think the `e.[f]` form could use a short explanation here.
- 148-149: I'm not sure I've understood the need for ZooLang expressions to
  refer to Rocq terms represented ZooLang values.


## Minor comments/questions

- 80-81: the authors mention additional/supplementary material, but I cannot see
  this on the submission in HotCRP.
  _edit_: I can see now this was non-anonymous.
- §2:
  - I feel that this related work section would be better placed towards the end
    of the paper - on a full read-through, various parts of it are rather
    mysterious until later.
  - 95: "is not based on Iris" this seems phrased as a criticism - is not being
    based on Iris intrinsically a shortcoming?
  - It seems worth comparing to RustBelt, given the focus on verification of
    real-world languages and the common use of Iris.
- 146: mutually recursive functions are "treated specifically" - a forward
  pointer would be useful here.
- Figure 2: this lies unfortunately (and perhaps slightly confusingly) in the
  middle of an inline code snippet. Ideally these would be untangled.
- 181: the requirement for shallow `match` seems somewhat restrictive, given
  OCaml's powerful patterns and prevalence of their usage.  Could the author(s)
  envisage supporting more powerful patterns?  E.g. by extending ZooLang, or by
  some (untrusted) compilation of non-shallow pattern matches?
- 295: "the aforementioned guarantee is arguably not sufficient" this is a
  fairly strong claim, and at first I wondered if the author(s) had proposed
  this to OCaml developers.  Later, I realised various proposals have indeed
  been made - I wonder if these should be signposted much earlier (at least in
  the list of contributions in §1, which states that the author(s) have
  refined/extended OCaml, but does not make clear that these changes have been
  proposed to become part of mainline OCaml).
- §5.3
  - 299-306: I'm struggling to follow/understand this argument.
  - 320-322: again struggling with these few lines.
  - 334-338: this paragraph/example is quite illuminating! I think this section
    would be easier to follow if the author(s) were to lead with this example.
- 431: unaddressed "TODO"


## Typos
- 52 and 353: "consists ~~in~~" -> "consists of"
- 82: "has only be" -> "has only been" (though I suppose this wouldn't appear in
  a final submission)
- 231: maybe (?) an omission of the module name for "double-ended queue"?
- 275: "as **it** basically ..." I assume this is referring to physical
  equality, but the sentence structure suggests it is referring to structural
  equality. Perhaps "as **the latter** ..."
- 338: "physical~~ly~~ equality"
- 434: "indexed over ~~it~~" (?)



Review #18B
===========================================================================

Overall merit
-------------
2. Weak reject

Reviewer expertise
------------------
3. Knowledgeable

Review
------
This paper describes a mechanism for deeply embedding a large subset
of the (concurrent) OCaml 5 language into Rocq/Iris in order to
support algorithm verification using concurrent separation logic. The
encoding, called Zoo, is in the style of the exising Iris HeapLang
language, but extended to support Ocaml features including algebraic
data types, mutual recursion, concurrency primitives from the Atomic
library, and physical equality tests. The authors also describe
proposed extensions to OCaml itself to support more predictable
physical equality testing and atomic record fields and arrays.  The
Rocq development is promised as supplemental material, but is not in
fact present.

This paper covers some interesting territory. The goal of using Iris
to reason about fine-grained concurrency in OCaml is a worthy one,
and the authors have evidently done quite a bit of work to construct
the Zoo language and translation. 

Unfortunately, I found the paper to hard to read and missing a lot of
essential explanations.  Some mysteries might have been cleared up by
looking at the Rocq development, but that was not available. In view
of these presentation problems, I'm not sure that I understand the
work properly, but I do see some big issues:

- Although the paper gives a lot of details illustrating the broad
coverage of Zoo, it is very short on examples of actual verifications
(just two short algorithms).  The Conclusion contains references to
further examples, but these are anonymized away.  Is there any more
evidence that this verification approach is actually useful in
practice?

- Fully 1/3 of the paper is devoted to the issue of encoding OCaml's
(under)definition of physical equality in Zoo. While this is an
interesting issue, I was not convinced that it is so important in
practice, since it can be worked around (without OCaml language
changes) by including a mutable field to force OCaml's physical
equality to behave better. Also, it is strange that the discussion
does not consider the pros and cons of using a typed representation
for Zoo, which would greatly ease the confusion problems (at least for
single-word encodings).

- The proposed OCaml extensions for atomic record fields and arrays in
section 7 are interesting, but have essentially nothing to do with
verification or Zoo, so it is not clear why they belong in an ITP
paper.

For these reasons, I do not favor accepting the paper in its present form.

Detailed Comments for Authors:

Section 2. This section would be much clearer if it came at the end of the paper,
after the relevant topics have been raised. 

163: "supported through the Array standard module" But does this involve adding
additional primitives?

Section 3.1. It is never stated clearly that this is surface syntax (Rocq notations)
for an underlying AST.  Also, nothing at all is said about how the
semantics of Zoo are defined. 

Seciton 3.3. The syntax of Iris specifications needs more detailed explanation
throughout, and more auxiliary definitions need to be stated explicitly.
For example, in Lemma stack_push_spec, what are $\iota$? and $\uparrow\iota$?
What are the definitions of `stack_inv` or `stack_model`?
What is the syntax for (private) postconditions?
The paragraph starting at 194 is completely mysterious. 

Section 4.2. Completely unclear what this boilerplate is for. 

Section 4.4.  The aspects of this involving Atomic.Loc make no sense until
after Section 7. (The forward pointer in footnote 3 is not sufficient.)

298: Lemma physseq_spec. Again, the syntax of the post-condition needs explanation.

302: "However, assuming ..." Don't know what this is trying to say.

321: "restricting compared values similarly to typing" What does this mean?

371: Surely no compiler will do this in practice! A slightly more plausible
example might be:

  val x = Some 0
  val y = x (* might make a copy *)
  let test = x == y`

431: Unfinished TODO.

Comments for Authors:

Small points, typos, etc:

92: "embedded" Is this intended to mean "deeply embedded"?

Figure 2: binders: what is "<>".  How can RocQ terms $t$ appear as expressions?

146: "specifically" -> "separately" or "specially" (?)

194: "private condition" -> "private precondition".

274: "as it" -> "which"

392: second "that" -> "have"

434: "over it a" -> "over a" (?)



Review #18C
===========================================================================

Overall merit
-------------
3. Weak accept

Reviewer expertise
------------------
3. Knowledgeable

Review
------
This paper introduces a deeply embedded language ZooLang within the Iris framework, which is similar to HeapLang but includes additional features, specifically around concurrency, and semantics which make it more amenable as a target for translation from OCaml 5. They also have a tool ocaml2zoo which performs this translation. 

The paper was clear and readable, but the formalization was not the focus. The main discussion concerned the specification of physical equality and some new features added to OCaml to be able to express the desired atomic operations.

I learned about some bad OCaml design decisions by reading this, for example that `Any 0 = Any false`, or that structural equality compares object graphs for isomorphism rather than bisimulation. It seems unfortunate that Zoo will inherit this mess into Rocq.

I am dutifully impressed by the breadth of work displayed here, and it's good to see some interaction with the OCaml compiler development team. But I think this paper would be better suited for a PL conference as written; an ITP paper should have more about the formalization and less about the compiler extensions.

Line Notes
---
* L13: concurrency expert -> a concurrency expert
* L19: Treiber stack -> the Treiber stack
* L20: delicate questions -> some delicate questions
* L22: concurrent programs -> kinds of concurrent programs
* L77: Treiber stack -> the Treiber stack
* L80: The artifact was not included with the submission. (I will use https://github.com/clef-men/zoo/tree/edc6965 as a substitute. Anonymize better next time.)
* L82: be -> been
* L131: physical -> physical equality
* L133: languages, -> languages, and
* Fig. 1: What are `[]` and `e1 :: e2`? I infer from L209 that this is not list nil / cons, and it would be weird to have nil/cons as separate from regular data types anyway. L147 also mentions "sequence" but I don't know if this means linked lists or arrays or something else (n-ary tuples? No, `(e1,...,en)` also exists). If it's just syntax which refers to `Nil` and `Cons` from the basis library, perhaps just exclude them from this figure or put them in a separate category to make it clear they are just sugar.
* L146: specifically -> specially
* L190: angular brackets -> angle brackets
* L209: What is `in_type "t"` doing? Is `"t"` the name of the variable matched on after L216? Or is it a type tag? Do you have type tags? (That is, can I define multiple types that have constructors `Nil` and `Cons`, which I believe is legal in OCaml as long as they are in separate scopes?)
* L249: Doesn't this limit your ability to scale up later?
* L255: I realize this may seem like a digression, but you should at least explain what the types of `Proph` and `Resolve` are and how they are used. It is a bit alarming to just say "our semantics predicts the future" and then move on. Even more so when these are apparently not simply artifacts of the formalization but also have realizations as OCaml library functions. How are those functions implemented?
* L274: as it -> which
* L338: physically -> physical
* L392: that the same tags -> have the same tags
* L421+4: Next -> Cons
* L431: left a TODO
* L434: over it -> over
