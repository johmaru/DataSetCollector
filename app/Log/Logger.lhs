> {-# LANGUAGE OverloadedStrings #-}
> module Log.Logger where

> import System.Directory (doesDirectoryExist)
> import Control.Monad.IO.Class (MonadIO, liftIO)

> checkDirectory :: MonadIO m => FilePath -> m Bool
> checkDirectory path = liftIO $ do
>      exist <- doesDirectoryExist path
>      return exist