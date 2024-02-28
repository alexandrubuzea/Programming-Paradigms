helper(Start, End, _, []) :- Start > End, !.
helper(Start, End, Step, [Start | Rest]) :- NewStart is Start + Step, helper(NewStart, End, Step, Rest).

generateEven(N, List) :- End is 2 * N, helper(2, End, 2, List).

run1() :- generateEven(10, List), write(List).

generateEven2(0, []) :- !.
generateEven2(N, List) :- Dec is N - 1, generateEven2(Dec, Res), Last is 2 * N, append(Res, [Last], List).

run2() :- generateEven2(10, List), write(List).