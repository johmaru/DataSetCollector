> module Main where
> import Log.Logger(checkDirectory)
> import System.Directory (createDirectory)
> import Data.IORef
> import System.IO.Unsafe (unsafePerformIO)
> import Libs.TimeCarry(logTime)

> data Log = Log { log :: String }

  ログの時間を記録するグローバル変数

> instanceLogTime :: IORef String
> instanceLogTime = unsafePerformIO (logTime >>= newIORef)
> main :: IO ()
> main = do 
>           initialize





> initialize :: IO ()
> initialize = do
>           exist <- checkDirectory "logs"
>           if exist then do 
>                  logContent <- readIORef instanceLogTime
>                  let filePath = "logs/" ++ logContent ++ ".txt"
>                  writeFile filePath logContent
>           else do  createDirectory "logs"
>                    logContent <- readIORef instanceLogTime
>                    let filePath = "logs/" ++ logContent ++ ".txt"
>                    writeFile filePath logContent
>                    return ()