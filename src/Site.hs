{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Control.Monad
import           Data.ByteString (ByteString)
import qualified Data.Foldable as F
import           Data.Monoid
import qualified Data.Text as T
import           Data.Traversable
import           Debug.Trace
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Router
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Text.XmlHtml (Node (..))
import           Heist
import           Heist.Compiled (yieldPureText)
import           Heist.Interpreted (textSplice)
import           Splices
------------------------------------------------------------------------------
import           Application

handleRoot = withSplices sps $ render "home" where
    sps = do
        "li-active" ## pickActive "home"

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("", ifTop handleRoot)
         , ("static", serveDirectory "static")
         , ("", routeWith routeAppUrl)
         ]


routeAppUrl :: AppUrl -> Handler App App ()
routeAppUrl appUrl =
    case appUrl of
      -- Login     -> with auth handleLogin
      -- Logout    -> with auth handleLogout
      Count n   -> writeText $ ("Count = " `T.append` (T.pack $ show n))
      Echo text -> writeText text
      Paths ps  -> writeText $ T.intercalate " " ps

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    h <- nestSnaplet "" heist $ heistInit' "templates" heistConfig
    r <- nestSnaplet "router" router $ initRouter ""
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)

    -- NOTE: We're using initJsonFileAuthManager here because it's easy and
    -- doesn't require any kind of database server to run.  In practice,
    -- you'll probably want to change this to a more robust auth backend.
    a <- nestSnaplet "auth" auth $
           initJsonFileAuthManager defAuthSettings sess "users.json"
    addRoutes routes
    addAuthSplices h auth
    return $ App h r s a
    where
        heistConfig = mempty
                    { hcLoadTimeSplices = defaultLoadTimeSplices
                    , hcInterpretedSplices = int
                    }
        int = do
            "urlHome" ## textSplice "/"
            "urlLogin" ## urlSplice Login
