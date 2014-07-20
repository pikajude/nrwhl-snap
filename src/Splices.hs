{-# LANGUAGE OverloadedStrings #-}

module Splices where

import Control.Lens
import qualified Data.Map as M
import Data.Maybe
import qualified Data.Text as T
import Heist.Interpreted (stopRecursion)
import Heist
import Text.XmlHtml (Node (..))

_elementAttrs :: Lens' Node (M.Map T.Text T.Text)
_elementAttrs = lens (M.fromList . elementAttrs)
    (\ nod as -> nod { elementAttrs = M.toList as })

_elementTag :: Lens' Node T.Text
_elementTag = lens elementTag (\ nod t -> nod { elementTag = t })

pickActive context = do
    n <- getParamNode
    let newNode =
         case n ^? _elementAttrs . ix "context" of
             Just x | x == context -> n
                 & _elementAttrs . at "class" . non ""
                     %~ (T.unwords . ("active" :) . T.words)
             _ -> n
    return [newNode & _elementAttrs . at "context" .~ Nothing
                    & _elementTag %~ unSuffix "-active"]
    where unSuffix s t = fromMaybe t $ T.stripSuffix s t
