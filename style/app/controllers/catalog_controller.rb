# -*- encoding : utf-8 -*-
class CatalogController < ApplicationController  

  include Blacklight::Catalog

  before_filter :load_map_results, :only => :index

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }

    config.spell_max = 5
    config.add_facet_fields_to_solr_request!

    #Index Configuration
    #config.index.title_field = "title_ss"
    config.add_index_field 'username_ss', :label => 'Creator'
    config.add_index_field 'photo_ss', :label => 'Photo'
    #Facet Configuration
    config.add_facet_field 'title_ss', :label => 'Post Title', :limit => 20
    config.add_facet_field 'username_ss', :label => 'Creator', :limit => 20
    #Map Configuration
    config.view.maps.type = "placename_coord"
    config.view.maps.bbox_field = "place_bbox"
    config.view.maps.placename_coords_field = "coords_sms"
    config.view.maps.tileurl = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    config.view.maps.attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
    config.view.maps.placename_coord_delimiter = '-|-'
    config.view.maps.minzoom = 16
    config.view.maps.maxzoom = 17
    config.view.maps.default = true
    #Search Configuration
    config.add_search_field('title') do |field|
      field.solr_parameters = { :qf => "title_text" }
    end
    config.add_search_field('creator') do |field|
      field.solr_parameters = { :qf => "user_text" }
    end
    #Show Configuration
    config.add_show_field 'username_ss', :label => "Creator"
    config.add_show_field 'description_ss', :label => "Description"
    config.add_show_field 'photo_ss', :label => "Photo"
  end

  def show
    super
    @map_results = [@document]
  end

  protected

  def cleaned_params
    params_copy = params.reject { |k,v| blacklisted_search_session_params.include?(k.to_sym) or v.blank? }

    params_copy.reject { |k,v| [:action, :controller].include? k.to_sym }
  end
  helper_method :cleaned_params

  private

  def load_map_results
    @map_results = get_search_results(params.merge(:map_view => true), {:start => 0, :rows => 10000}).first.docs unless params[:controller] == "bookmarks"
  end

  def require_coordinates(solr_params, user_params)
    return unless user_params[:map_view]
    solr_params[:fq] ||= []
    solr_params[:fq] << "coords_sms:['' TO *]"
  end

  def get_solr_response_for_doc_id(*args)
    solr_response, document = super
    return [solr_response, document]
  end

  def no_permissions
    flash[:error] = "Permission Denied"
    redirect_to root_path
  end

end 
