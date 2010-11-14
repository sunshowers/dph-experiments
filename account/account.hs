import Control.Monad
import Control.Concurrent
import Control.Concurrent.STM

newAccount amount = atomically (newTVar amount)

credit account amount = do
  balance <- readTVar account
  writeTVar account (balance + amount)

debit account amount = do
  balance <- readTVar account
  if (balance < amount)
    then retry
    else writeTVar account (balance - amount)

main = do
  a1 <- newAccount 1200
  a2 <- newAccount 2500
  b <- newAccount 4000
  
  atomically (
    do
      (debit a1 1500) `orElse` (debit a2 1500)
      credit b 1500
      )
  
  balanceA1 <- atomically (readTVar a1)
  balanceA2 <- atomically (readTVar a2)
  balanceB <- atomically (readTVar b)
  print balanceA1
  print balanceA2
  print balanceB
