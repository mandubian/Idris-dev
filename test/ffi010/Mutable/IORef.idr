||| Machinery for mutable variables
module Mutable.IORef

%include c "mutvar.h"

%default total

-- export
-- data IORef :  (a : Type) -> Type where
--   MkIORef : C -> IORef a

-- export
-- newIORef : a -> IO (IORef a)
-- newIORef {a} x = do
--   me  <- getMyVM
--   ptr <- foreign FFI_C "idris_newMutVar" (Ptr -> Raw a -> IO Ptr) me (MkRaw x)
--   pure $ MkIORef ptr
--
-- export
-- readIORef : IORef a -> IO a
-- readIORef {a} (MkIORef ptr) = do
--   me  <- getMyVM
--   MkRaw x <- foreign FFI_C "idris_readMutVar" (Ptr -> Ptr -> IO (Raw a)) me ptr
--   pure $ x


-- a mutable variable of type a in the IO Monad
export
data IORef :  (a : Type) -> Type where
  MkIORef : MutVar -> IORef a

export
newIORef : a -> IO (IORef a)
newIORef {a} x = do
  me  <- getMyVM
  mv <- foreign FFI_C "idris_newMutVar" (Ptr -> Raw a -> IO MutVar) me (MkRaw x)
  pure (MkIORef mv)

export
readIORef : IORef a -> IO a
readIORef {a} (MkIORef mv) = do
  me  <- getMyVM
  MkRaw x <- foreign FFI_C "idris_readMutVar" (Ptr -> MutVar -> IO (Raw a)) me mv
  pure x

export
writeIORef : IORef a -> a -> IO ()
writeIORef {a} ref x = let MkIORef mv = ref in do
  me  <- getMyVM
  foreign FFI_C "idris_writeMutVar" (Ptr -> MutVar -> Raw a -> IO ()) me mv (MkRaw x)
  pure $ ()
