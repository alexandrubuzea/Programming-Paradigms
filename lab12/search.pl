nod(a).
nod(b).
nod(c).
nod(d).
nod(e).
nod(f).

arc(a/b).
arc(b/c).
arc(a/c).
arc(c/d).
arc(d/f).
arc(d/e).

edge(X, Y) :- arc(X/Y); arc(Y/X).

start_node(a).
final_node(d).

% get_neighbours(?Node, -Neighbours)
get_neighbours(Node, Neighbours) :- nod(Node), findall(Nei, edge(Node, Nei), Neighbours).

search_bfs(Discovered) :- start_node(Start),
                          bfs([Start], [Start/none/0], Discovered),
                          write(Discovered).

% bfs(+Queue, +Visited, -Discovered)
% Visited = [x/y/7, ...]

bfs([], Visited, Discovered) :- !, Visited = Discovered.
bfs([Node|Rest], Visited, Discovered) :- get_neighbours(Node, Neighbours),
                                         findall(Nei, (member(Nei, Neighbours), \+ member(Nei/_/_, Visited)), FilteredNeighbours),
                                         member(Node/_/Dist, Visited),
                                         NewDist is Dist + 1,
                                         findall(Nei/Node/NewDist, member(Nei, FilteredNeighbours), NewTriplets),
                                         append(Visited, NewTriplets, NewVisited),
                                         append(Rest, FilteredNeighbours, NewQueue),
                                         bfs(NewQueue, NewVisited, Discovered).