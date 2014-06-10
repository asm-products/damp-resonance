class AdsDatatable 
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
        ad.category.name,
        link_to(ad.title, ad),
        (ad.price_cents) * 0.01,
        ad.description[0,100],
        "#{ad.distance_to(current_user.to_coordinates).round(0)} Miles",
        ad.city, 
        ad.state,
        ad.zip,
        ad.created_at.to_date
    ]
    end
   else
    ads.map do |ad|
      [
        ad.category.name,
        link_to(ad.title, ad),
        (ad.price_cents) * 0.01,
        ad.description[0,100],
        "NA",
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
    ads = Ad.reorder("#{sort_column} #{sort_direction}")
    ads = ads.page(page).per(per_page)
    if current_user
     if params[:sSearch].present?
      #ads = ads.near(current_user, 100).where("title ilike :search or description ilike :search or city ilike :search or state ilike :search or zip ilike :search", search: "%#{params[:sSearch_3]}%")
      #ads = ads.near(current_user, 100).where(quick_search)
      #ads = ads.near(current_user, 100)
      ads = ads.near(current_user, 5000).joins(:category).advanced_search( { title: params[:sSearch], description: params[:sSearch], city: params[:sSearch], state: params[:sSearch], zip: params[:sSearch], categories: { name: params[:sSearch] }} )
     end
      ads
    end
     if params[:sSearch].present?
      #ads = ads.where("title ilike :search or description ilike :search or city ilike :search or state ilike :search or state ilike :search or zip ilike :search", search: "%#{params[:sSearch_3]}%")
      #ads = ads.where(quick_search)
      ads = ads.joins(:category).advanced_search( { title: params[:sSearch], description: params[:sSearch], city: params[:sSearch], state: params[:sSearch], zip: params[:sSearch], categories: { name: params[:sSearch] } }, false )
      #ads = PgSearch.multisearch('camperva')
     end
      ads
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[category_id title price_cents description distance city state zip created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  
end