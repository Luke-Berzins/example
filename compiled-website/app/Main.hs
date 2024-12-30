{-# LANGUAGE OverloadedStrings #-}
import           Hakyll

main :: IO ()
main = hakyll $ do
    match "content/posts/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
