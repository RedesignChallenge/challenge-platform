IMAGE_EXTENSION_WHITELIST = %w(jpg jpeg gif png)
FILE_EXTENSION_WHITELIST = %w(pdf doc docx xls xlsx ppt pptx)

DEFAULT_LIKE = {
  scope: 'like',
  liked: {
    name: 'Liked',
    icon: 'fa fa-thumbs-up'
  },
  unliked: {
    name: 'Like',
    icon: 'fa fa-thumbs-o-up'
  }
}