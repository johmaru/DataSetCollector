module Libs.TimeCarry where 

import Data.Time ( UTCTime, getCurrentTime)
import qualified Data.Text as T
import Data.Text (Text)
import Data.Time.Format (formatTime, defaultTimeLocale)

getTime :: IO UTCTime

getTime = getCurrentTime

formatTimeString :: UTCTime -> Text
formatTimeString = T.pack . formatTime defaultTimeLocale "%Y-%m-%d_%H-%M-%S"

trim :: Text -> Text
trim = T.strip



logTime :: IO String
logTime = do
  time <- getTime
  let timeString = formatTimeString time
  let trimmed = trim timeString
  return (T.unpack trimmed)
  