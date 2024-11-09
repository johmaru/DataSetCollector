> {-# LANGUAGE OverloadedStrings #-}
> module Log.Logger where

> import System.Directory (doesDirectoryExist)
> import Control.Monad.IO.Class (MonadIO, liftIO)
> import Data.IORef ( newIORef, readIORef, IORef )
> import System.IO.Unsafe (unsafePerformIO)
> import Libs.TimeCarry(logTime)
> import Data.Time.Clock (getCurrentTime)

> data LogMessage = Info String | Warning String | Error String

> instanceLogTime :: IORef String
> instanceLogTime = unsafePerformIO (logTime >>= newIORef)
> logFilePath :: IO FilePath
> logFilePath = do
>      logContent <- readIORef instanceLogTime
>      return $ "logs/" ++ logContent ++ ".log"

> checkDirectory :: MonadIO m => FilePath -> m Bool
> checkDirectory path = liftIO $ do
>      exist <- doesDirectoryExist path
>      return exist

> logAdd :: LogMessage -> IO ()
> logAdd (Info msg) = do
>         path <- logFilePath
>         time <- getCurrentTime
>         appendFile path ("[Info] " ++ show time ++ ":" ++ msg ++ "\n")
> logAdd (Warning msg) = do
>         path <- logFilePath
>         time <- getCurrentTime
>         appendFile path ("[Warning] " ++ show time ++ ":" ++ msg ++ "\n")
> logAdd (Error msg) = do
>         path <- logFilePath
>         time <- getCurrentTime
>         appendFile path ("[Error] " ++ show time ++ ":" ++ msg ++ "\n")