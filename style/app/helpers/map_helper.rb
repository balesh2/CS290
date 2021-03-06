module MapHelper
  include BlacklightMapsHelper
  include Blacklight::UrlHelperBehavior

  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller, map_results.reverse)
    export.to_geojson
  end

  def map_results
    @map_results = Post.all
  end

  def map_counter(document)
    return nil if !@map_results || @map_results.length == 1
    return building_counter(document) if cleaned_params.blank?
    map_counter = @map_results.index{|d| d["id"] == document.id}
    map_counter += 1 if map_counter
    return map_counter
  end

  def link_to_map_document(doc, opts={:label => nil, :counter => nil})
    opts[:label] ||= document_show_link_field(doc)
    label = render_document_index_label doc, opts
    search_context = opts[:search_context].to_json if opts[:search_context].present?
    link_to label, catalog_path(doc, :search_context => search_context), document_link_params(doc, opts)
  end

  def render_thumbnail_img(doc, img_opts = {}, url_opts = {})
    value = if blacklight_config.view_config(document_index_view_type).thumbnail_method
              send(blacklight_config.view_config(document_index_view_type).thumbnail_method, doc, img_opts)
            elsif blacklight_config.view_config(document_index_view_type).thumbnail_field
              image_tag thumbnail_url(doc), img_opts
            end
    if value
      if url_opts === false || url_opts[:suppress_link]
        value
      else
        link_to_map_document doc, url_opts.merge(:label => value)
      end
    end
  end

end
