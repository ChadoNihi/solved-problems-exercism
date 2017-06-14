module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Elem a (LinkedList a)
    | Nil deriving (Eq, Show)

datum :: LinkedList a -> a
datum (Elem a _) = a

fromList :: [a] -> LinkedList a
fromList = foldr new nil

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = Elem -- x linkedList = (Elem x (linkedList))

next :: LinkedList a -> LinkedList a
next (Elem _ rest) = rest
next Nil = nil

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = go nil
    where
        go acc (Elem x xs) = go (new x acc) xs
        go acc Nil = acc

toList :: LinkedList a -> [a]
toList (Elem x xs) = x : toList xs
toList Nil = []
