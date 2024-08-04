class ChangeImageUrlToStringInProducts < ActiveRecord::Migration[7.1]
  def up
    # Remove ActiveStorage attachment columns if they exist
    remove_column :products, :image_url_attachment, :string if column_exists?(:products, :image_url_attachment)
    remove_column :products, :image_url_blob, :string if column_exists?(:products, :image_url_blob)

    # Add or change image_url to string
    change_column :products, :image_url, :string unless column_exists?(:products, :image_url)
  end

  def down
    change_column :products, :image_url, :string unless column_exists?(:products, :image_url)
  end
end
