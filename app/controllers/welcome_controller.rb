class WelcomeController < ApplicationController
  def index
  end

  def hello
  end

  def show

  end

  def get_markdown
    render json: {
        #md2html: Redcarpet::Markdown::new(Redcarpet::Render::HTML).render(params[:body])
        md2html: markdown(params[:body])
    }
  end
end
