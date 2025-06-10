module Api
  module V1
    class ShortUrlsController < ApplicationController
      include TimezoneHelper

      before_action :validate_multiple_url_param, only: [:batch_create]

      # @route POST /api/v1/shorten (api_v1_shorten)
      def create
        existing = ShortUrl.active.find_by(original_url: params[:url])
        return render json: { error: 'URL already shortened' }, status: :conflict if existing

        short_url = ShortUrl.new(original_url: params[:url])
        if short_url.save
          render json: short_url_create_response(short_url), status: :created
        else
          render json: { error: short_url.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # @route POST /api/v1/shorten/batch (api_v1_shorten_batch)
      def batch_create
        urls = params[:urls]
        results = urls.map do |url|
          existing = ShortUrl.active.find_by(original_url: url)
          if existing
            { original_url: url, error: 'URL already shortened', short_url: short_url(existing.short_code) }
          else
            short_url = ShortUrl.create(original_url: url)
            if short_url.persisted?
              { original_url: url, short_url: short_url(short_url.short_code) }
            else
              { original_url: url, error: short_url.errors.full_messages.join(', ') }
            end
          end
        end
        render json: results, status: :multi_status
      end

      # @route POST /api/v1/deactivate/:code (api_v1)
      def deactivate
        short_url = ShortUrl.find_by(short_code: params[:code], is_active: true)
        return render json: { error: 'No Active URL found' }, status: :not_found unless short_url

        short_url.update(is_active: false)
        render json: { message: 'Short URL deactivated' }, status: :ok
      end

      # @route GET /api/v1/analytics (api_v1_analytics)
      def analytics
        tz = parse_timezone(params[:timezone]) || ActiveSupport::TimeZone["UTC"]
        start_date = parse_date(params[:start_date], tz)
        end_date = parse_date(params[:end_date], tz)

        # Add pagination if we have large number of records
        urls = ShortUrl.includes(:clicks).all
        data = urls.map { |url| analytics_response(url, start_date, end_date) }

        render json: data, status: :ok
      end

      private

      def short_url_create_response(url)
        {
          original_url: url.original_url,
          short_url: short_url(url.short_code),
        }
      end

      def validate_multiple_url_param
        urls = params[:urls]
        if urls.blank? || !urls.is_a?(Array)
          render json: { error: 'Parameter `urls` is required and must be a non-empty array.' }, status: :bad_request
        end
      end

      def parse_date(date_str, tz)
        tz.parse(date_str) rescue nil
      end

      def filtered_click_count(url, start_date, end_date)
        return 0 unless start_date && end_date

        url.clicks.where(clicked_at: start_date..end_date.end_of_day).count
      end

      def analytics_response(url, start_date, end_date)
        {
          original_url: url.original_url,
          short_url: short_url(url.short_code),
          short_code: url.short_code,
          is_active: url.is_active,
          created_at: url.created_at,
          total_clicks: url.clicks.size,
          filtered_clicks: filtered_click_count(url, start_date, end_date)
        }
      end
    end
  end
end
