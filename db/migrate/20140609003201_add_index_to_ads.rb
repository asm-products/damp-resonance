class AddIndexToAds < ActiveRecord::Migration
  def change
  execute "
      create index on ads using gin(to_tsvector('english', title));
      create index on ads using gin(to_tsvector('english', description));"    
  end
end
