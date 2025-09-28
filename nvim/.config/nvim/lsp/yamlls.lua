-- Config based on: https://www.arthurkoziel.com/json-schemas-in-neovim/

return {
  settings = {
    yaml = {
      validate = true,
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = {
        -- MkDocs Material schema: https://squidfunk.github.io/mkdocs-material/
        -- creating-your-site/?h=schema#minimal-configuration
        ["https://squidfunk.github.io/mkdocs-material/schema.json"] = "mkdocs.yml",
      },
      customTags = {
        "!ENV scalar",
        "!ENV sequence",
        "!relative scalar",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji",
        "tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format",
        "tag:yaml.org,2002:python/object/apply:pymdownx.slugs.slugify mapping"
      }
    }
  }
}
