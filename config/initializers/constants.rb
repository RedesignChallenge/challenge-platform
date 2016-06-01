IMAGE_EXTENSION_WHITELIST = %w(jpg jpeg gif png)
FILE_EXTENSION_WHITELIST = %w(pdf doc docx xls xlsx ppt pptx)

DEFAULT_LIKE = {
  scope: 'like',
  liked: {
    icon: 'fa fa-thumbs-up'
  },
  unliked: {
    icon: 'fa fa-thumbs-o-up'
  }
}

MAIN_ENTITIES = [Experience, Idea, Recipe, Solution]
COMMENTABLE_ENTITIES = MAIN_ENTITIES + [Cookbook]

OPEN_RECIPE_SUBMISSIONS = false