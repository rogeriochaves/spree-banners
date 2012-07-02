module Spree
  module BannersHelper

    def insert_banner(params={})
      # max items show for list
      max = params[:max] || 1
      # class items show
      cl = params[:class] || "banner"
      # style items show
      style = params[:style] || "list"

      banner = Banner.enabled.limit(max)
      unless banner.blank?
        # random order
        banner = banner.sort_by{rand}

        if (style == "list")
          content_tag(:ul, raw(banner.map do |ban| content_tag(:li, link_to(image_tag(ban.attachment.url(image_size.to_sym)), ban.url), :class => cl) end.join) )
        else
          raw(banner.map do |ban|
            if ban.url?
              content_tag(style.to_sym, link_to(image_tag(ban.attachment.url(:custom)), ban.url), :class => cl)
            else
              content_tag(style.to_sym, image_tag(ban.attachment.url(:custom)), :class => cl)
            end
          end.join)
        end
      end
    end
  end
end
