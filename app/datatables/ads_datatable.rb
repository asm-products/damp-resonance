class AdsDatatable < ApplicationController
  before_filter :authenticate_user!
  delegate :current_user, :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Ad.count,
      iTotalDisplayRecords: ads.total_count,
      aaData: data
    }
  end 

private
  
  def data
   if current_user
    ads.map do |ad|
      [
        "#{ad.distance_to(current_user.to_coordinates).round(0)} Miles",
        ad.category.name,
        link_to(ad.title, ad),
        (ad.price_cents) * 0.01,
        ad.description[0,100],
        ad.city, 
        ad.state,
        ad.zip,
        ad.created_at.to_date
    ]
    end
   else
    ads.map do |ad|
      [
        "NA",
        ad.category.name,
        link_to(ad.title, ad),
        (ad.price_cents) * 0.01,
        ad.description[0,100],
        ad.city, 
        ad.state,
        ad.zip,
        ad.created_at.to_date
      ]
    end
   end
  end

  def ads
    @ads ||= fetch_ads
  end

  def fetch_ads
    ads = Ad.order("#{sort_column} #{sort_direction}")
    ads = ads.page(page).per(per_page)
    if user_signed_in?
     if params[:sSearch].present?
      ads = ads.nearest(current_user, 1500).joins(:category).advanced_search( { title: params[:sSearch], description: params[:sSearch], city: params[:sSearch], state: params[:sSearch], zip: params[:sSearch], categories: { name: params[:sSearch] }}, false )
     end
      ads.nearest(current_user, 1500)
    else
     if params[:sSearch].present?
      ads = ads.joins(:category).advanced_search( { title: params[:sSearch], description: params[:sSearch], city: params[:sSearch], state: params[:sSearch], zip: params[:sSearch], categories: { name: params[:sSearch] } }, false )
     end
      ads
    end
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[ title category_id title price_cents description city state zip created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  
end