{-
    The Tree datatype as defined in the laboratory    
-}

data Tree a = EmptyTree | Node a (Tree a) (Tree a)

-- creates a tree with only one node from a value
singleton :: a -> Tree a
singleton = undefined

-- inserts a value in a binary search tree (values can be compared by order - >, <, >=, <=)
insert :: Ord a => a -> Tree a -> Tree a
insert = undefined

-- inserts a list of elements into a tree
-- use insert !
insertElements :: Ord a => [a] -> Tree a -> Tree a
insertElements = undefined

-- builds a tree from a list
-- write it point free !
buildTree :: Ord a => [a] -> Tree a
buildTree = undefined

-- searches a value in a binary search tree
-- use guards !
search :: Ord a => a -> Tree a -> Bool
search = undefined

-- computes the sum of the numbers that are in a binary search tree
-- use search !
sumOfSelected :: (Num a, Ord a) => [a] -> Tree a -> a
sumOfSelected = undefined

-- flattens a tree
flatten :: Tree a -> [a]
flatten = undefined

-- checks if a tree is a binary search tree
-- use local recursive functions
checkBST :: Ord a => Tree a -> Bool
checkBST = undefined

{-
    (Reminder from the SD/SDA course): An AVL tree is a data structure
    that is a balanced binary search tree with the property that for any node
    in the tree, the difference in height between the left and the right subtree
    does not exceed 1.
    For example, Node 2 (Node 1 EmptyTree) EmptyTree is an AVL tree
                 Node 3 (Node 2 (Node 1 EmptyTree EmptyTree) EmptyTree) EmptyTree
                        is not an AVL tree 
-}

-- now, implement the following functions (over an AVL)

insertAVL :: Ord a => a -> Tree a -> Tree a
insertAVL = undefined

searchAVL :: Ord a => a -> Tree a -> Bool
searchAVL = undefined

checkAVL :: Ord a => Tree a -> Bool
checkAVL = undefined

{-
    Using the Tree type we can define aliases for usages of this type.
    One example is Map, which is a dictionary that instead of hashing
    uses a binary tree with key comparison.
-}

type Map k v = Tree (k, v) -- similar to std::map<K,V> or Java Map<K,V>

lookup :: Ord k => k -> Map k v -> Maybe v
lookup = undefined

contains :: Ord k => k -> Map k v -> Bool
contains = undefined

put :: Ord k => k -> Map k v -> Map k v
put = undefined

getKeys :: Ord k => Map k v -> [k]
getKeys = undefined

fromList :: Ord k => [(k, v)] -> Map k v
fromList = undefined