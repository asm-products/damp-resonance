class AdsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Ad.count,
      iTotalDisplayRecords: ads.total_entries,
      aaData: data
    }
  end

private

  def data
    ads.map do |ad|
      [
        link_to(ad.title, ad)
      ]
    end
  end

  def ads
    @ads ||= fetch_ads
  end

  def fetch_ads
    ads = Ad.order("#{sort_column} #{sort_direction}")
    ads = ads.page(page).per_page(per_page)
    if params[:sSearch].present?
      ads = ads.where("title like :search", search: "%#{params[:sSearch]}%")
      #Ads = ads.all
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
    columns = %w[title]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end