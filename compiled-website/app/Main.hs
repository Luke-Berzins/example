-- Create an index.html from your posts
create ["index.html"] $ do
    route idRoute
    compile $ do
        posts <- loadAll "content/posts/*"
        let indexCtx =
                listField "posts" defaultContext (return posts) <>
                defaultContext

        makeItem ""
            >>= loadAndApplyTemplate "templates/default.html" indexCtx
            >>= relativizeUrls
