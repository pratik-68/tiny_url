class RedirectController < ApplicationController
  # @route GET /:code (short)
  def show
    short_url = ShortUrl.find_by(short_code: params[:code], is_active: true)
    return render_not_found unless short_url

    short_url.clicks.create(clicked_at: Time.current)

    redirect_to short_url.original_url, allow_other_host: true
  end

  private

  def render_not_found
    render json: { error: 'URL not found' }, status: :not_found
  end
end
