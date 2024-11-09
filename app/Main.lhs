> module Main where
> import Log.Logger(checkDirectory,instanceLogTime,logFilePath,logAdd,LogMessage(..))
> import System.Directory (createDirectory)
> import Data.IORef ( readIORef)
> import System.Console.ANSI (clearScreen)
> import System.Exit (exitSuccess)
> import Control.Concurrent.Async (async,wait)
> import System.IO (stdin, BufferMode(..), hSetBuffering, hReady)
> import Control.Monad (when)
  
> data Log = Log { log :: String }

  ログの時間を記録するグローバル変数

> main :: IO ()
> main = do 
>           initialize
>           logAdd (Info "Initialized")
>           mainTask

> mainTask :: IO ()
> mainTask = do
>           clearScreen
>           putStr "Hello,Please input choice\n\n"
>           putStrLn "1:Start|2:Setting|3:Exit"
>           input <- getInputBuffer
>           case input of
>             [c] -> mainChoice c
>             _   -> do
>                        putStrLn $ input ++ " is invalid choice, please try again."
>                        logTask <- async $ logAdd (Warning ("Invalid choice " ++ input))
>                        wait logTask
>                        mainTask


> clearInputBuffer :: IO ()
> clearInputBuffer = do
>         hSetBuffering stdin NoBuffering
>         ready <- hReady stdin
>         when ready $ do
>                 _ <- getChar
>                 clearInputBuffer

> getInputBuffer :: IO String
> getInputBuffer = do
>         hSetBuffering stdin NoBuffering
>         input <- getLine
>         clearInputBuffer
>         return input


> mainChoice :: Char -> IO ()
> mainChoice choice =  case choice of
>                '1' -> do
>                        putStrLn "Start"
>                        logAdd (Info "Start")
>                '2' -> do
>                        putStrLn "Setting"
>                        logAdd (Info "Setting")
>                '3' -> do
>                        putStrLn "Exit"
>                        logTask <- async $ logAdd (Info "Exit")
>                        wait logTask
>                        exitSuccess
>                _   -> do
>                        input <- getInputBuffer
>                        putStrLn $ input ++ " is invalid choice, please try again."
>                        logTask <- async $ logAdd (Warning ("Invalid choice " ++ input))
>                        wait logTask
>                        mainTask


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