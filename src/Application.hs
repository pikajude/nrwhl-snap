{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -ddump-splices #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import Control.Lens
import Control.Monad.State (get)
import Data.Text
import Snap.Snaplet
import Snap.Snaplet.Auth
import Snap.Snaplet.Heist
import Snap.Snaplet.Router.Types
import Snap.Snaplet.Session
import Web.Routes.TH

data AppUrl
    = Login
    | Logout
    | Count Int
    | Echo Text
    | Paths [Text]
    deriving (Eq, Read, Show)

derivePathInfo ''AppUrl

------------------------------------------------------------------------------
data App = App
    { _heist :: Snaplet (Heist App)
    , _router :: Snaplet RouterState
    , _sess :: Snaplet SessionManager
    , _auth :: Snaplet (AuthManager App)
    }

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist


------------------------------------------------------------------------------
type AppHandler = Handler App App

instance HasRouter (Handler App App) where
    type URL (Handler App App) = AppUrl
    getRouterState = with router get

instance HasRouter (Handler b RouterState) where
    type URL (Handler b RouterState) = AppUrl
    getRouterState = get
