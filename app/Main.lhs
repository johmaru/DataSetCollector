> module Main where
> import Log.Logger(checkDirectory,instanceLogTime,logFilePath,logAdd,LogMessage(..))
> import System.Directory (createDirectory)
> import Data.IORef ( readIORef)

> data Log = Log { log :: String }

  ログの時間を記録するグローバル変数


> main :: IO ()
> main = do 
>           initialize
>           logAdd (Info "Initialized")





> initialize :: IO ()
> initialize = do
>           exist <- checkDirectory "logs"
>           if exist then do 
>                  logContent <- readIORef instanceLogTime
>                  filePath <- logFilePath
>                  writeFile filePath ("Log file created at " ++ logContent ++ "\n\n")
>                  return ()
>           else do  createDirectory "logs"
>                    logContent <- readIORef instanceLogTime
>                    filePath <- logFilePath
>                    writeFile filePath ("Log file created at " ++ logContent ++ "\n\n")
>                    return ()