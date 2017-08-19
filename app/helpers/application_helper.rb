module ApplicationHelper
  include LetterAvatar::AvatarHelper

  def markdown(text)
    sanitize_markdown Redcarpet::Markdown::new(Redcarpet::Render::HTML).render(text)
  end

  def sanitize_markdown(text)
    Sanitize.fragment(text, Sanitize::Config::RELAXED)
  end

  def timeago(time, options = {})
    return "" if time.blank?
    options[:class] = options[:class].blank? ? "timeago" : [options[:class], "timeago"].join(" ")
    options[:title] = time.iso8601
    text = time.to_date
    content_tag :abbr, text, options
  end

end
