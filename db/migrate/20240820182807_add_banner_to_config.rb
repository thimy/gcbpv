class AddBannerToConfig < ActiveRecord::Migration[7.1]
  def change
    add_column :configs, :banner, :text
  end
end
