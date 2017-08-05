module ApplicationHelper
  include LetterAvatar::AvatarHelper

  def markdown(text)
    sanitize_markdown Redcarpet::Markdown::new(Redcarpet::Render::HTML).render(text)
  end

  def sanitize_markdown(text)
    Sanitize.fragment(text, Sanitize::Config::RELAXED)
  end

end
