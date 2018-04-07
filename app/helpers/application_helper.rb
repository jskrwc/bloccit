module ApplicationHelper
  def form_group_tag(errors, &block)
    # CP 22  The & turns the block into a Proc -- a block that can be reused like a variable.
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    #  The content_tag helper method method -- takes a symbol argument, a block, and an options hash. It then creates the symbol-specified HTML tag with the block contents, and if specified, the options.

    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end


end
