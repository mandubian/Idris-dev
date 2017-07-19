module Main

import Mutable.IORef

data Foo : a -> Type where
  MkFoo: (idx: Int) -> (val: a) -> Foo a

Show a => Show (Foo a) where
  show (MkFoo idx val) = "Foo idx:" ++ (show idx) ++ " val:" ++ (show val)

runInt : (max: Int) -> (ref: IORef Int) -> IO (IORef Int)
runInt max ref = do
  i <- readIORef ref

  if (i < max)
  then do writeIORef ref (i + 1)
          runInt max ref
  else pure ref

runFoo : Show a => (max:Int) -> IORef (Foo a) -> (Foo a -> Foo a) -> IO (IORef (Foo a))
runFoo max ref f = do
  MkFoo idx val <- readIORef ref

  -- if ((idx `mod` 100000) == 0) then printLn ((show idx) ++ " " ++ (show s)) else pure ()
  if (idx < max)
  then do writeIORef ref (f (MkFoo (idx + 1) val))
          runFoo max ref f
  else pure ref

main : IO ()
main = let max = 1000000 in
  do
    refInt <- newIORef 0
    runInt max refInt
    i <- readIORef refInt
    printLn i

    refFoo <- newIORef (MkFoo 0 "A")
    runFoo max refFoo (\foo => let MkFoo i s = foo in MkFoo i ((singleton(strHead s)) ++ (show i)))
    foo <- readIORef refFoo
    printLn foo
    pure ()
