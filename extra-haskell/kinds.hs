{-
    Kinds can be expressed very simple as types of types. For example, if we think about
    simple types, there is a difference between a concrete type (for example, Integer) and
    a type constructor (for example, Maybe):
    - the concrete type Integer has a set of values associated, values that we can regard as
    of having the type Integer: 0, 1, 2 ...
    - on the other hand, Maybe does not have any such values associated, but instead acts as
    a "function" onto types: it takes a concrete type (for example, String) and creates
    a new type, Maybe String.
    
    This behaviour can be extended: we can have a type constructor that receives another type
    constructors. Take as an example the following type constructor:

    newtype T f g a = T (f a -> g a)

    The type constructor T receives two another type constructors and one concrete type, and
    creates a new type. In order to maintain coherence among new types's creation, we need to
    introduce typing (enforce correctness) for ... types themselves:

    - about any concrete type, we'll say it has the kind *
    - about an unary type constructor (e.g. Maybe), we say that it has the kind * => *
    - we can construct more complex kinds, such as (* => *) => (* => *) => * => * which is the
    kind for T defined above (receives two unary type constructors aka two * => * and a concrete
    type aka * and returns a *, which is a new type).

    The kind of an expression can be checked in GHC interpreter using :k

    Exercises: i. first derive, then check the kinding for the following type expressions:
    - (->)
    - Either Int
    - Either
    - data Fix f a = Fix (f (Fix f a)) | Base a

    ii. Let's suppose we define a type like:
    newtype C a b = C (a -> b -> a b)

    What is the kind for C ? Test in GHCi and explain the result.
-}

newtype T f g a = T (f a -> g a) -- :k T -> ?
