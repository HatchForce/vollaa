class HomeController < ApplicationController

  include HomeHelper
  #caches_action :results

  def index

  end

  def search

  end

  def adv_search
    @properties = Property.all
  end

  def results
     #raise params.to_yaml
    @properties = Property.all
    session[:query] = params[:what], params[:where] if params[:what].present? || params[:where].present?

    $s_qry = [] if session[:s_qry_ary].nil?
    $s_qry.push [params[:what], params[:where]] if params[:what].present? || params[:where].present?
    session[:s_qry_ary] = ($s_qry = $s_qry.uniq) if $s_qry.present?

    @search = Property.search do
      fulltext (params['what']. present?? params['what'] : "") + ' ' + (params['where'].present?? params['where'] : "")

      facet :property_type, :bedrooms, :property_price, :city, :state, :built_up_area, :property_for

      with(:property_type, params[:property_type]) if params[:property_type].present?
      with(:property_for, params[:property_for]) if params[:property_for].present?
      with(:bedrooms, params[:bedrooms].to_i) if params[:bedrooms].present?
      with(:city, params[:city]) if params[:city].present?
      with(:state, params[:state]) if params[:state].present?
      with(:city, params[:area]) if params[:area].present?
      with(:source, params[:source]) if params[:source].present?
      with(:created_at, params[:created_at]) if params[:created_at].present?
      with(:property_description, params[:prop_desc]) if params[:prop_desc].present?
      with(:property_price, params[:property_price]) if params[:property_price].present?

      with(:property_price).greater_than(params[:price_min]) if params[:price_min].present? and !params[:price_max].present?
      with(:property_price).less_than(params[:price_max]) if params[:price_max].present? and !params[:price_min].present?
      with(:property_price, params[:price_min]..params[:price_max]) if params[:price_max].present? and params[:price_min].present?

      with(:built_up_area).greater_than(params[:area_min]) if params[:area_min].present? and !!params[:area_max].present?
      with(:built_up_area).less_than(params[:area_max]) if params[:area_max].present? and !params[:area_min].present?
      with(:built_up_area, params[:area_min]..params[:area_max]) if params[:area_max].present? and params[:area_min].present?
      with(:built_up_area).less_than(params[:area_max]) if params[:area_max].present? and !!params[:area_min].present?

      #@sort_column =  Property.column_names.include?(params[:sort]) ? params[:sort] : :bedrooms
      #@sort_dir = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
      paginate :page => params[:page], :per_page => 10
      order_by params[:sort], params[:direction] if params[:sort].present?
    end

    #sort_by('xx','zz')

    @results = @search.results

    @search.facet(:property_type).rows.each do |facet|
      @value = facet.value
      @count = facet.count
    end
  end


  def view_results
    self.results
  end

  def side_nav
    self.results
  end


  def send_details
    property_id = params[:property_id]
    emails = params[:emails].split(',')
    emails.each do |email|
      email = email.strip
      if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
        @mail = UserMailer.mail_property_details(email, property_id).deliver
        raise "returned to send_details"
      end
    end
  end

  def revert_recent
    $s_qry = []
    session[:s_qry_ary] = ''
    #session[:query] = ''
    render :json => {:status => 'ok'}
  end

end
