class AddImageLinkToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :poster_url, :string
  end
end
