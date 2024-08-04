class RemoveActiveStorageColumnsFromProducts < ActiveRecord::Migration[7.1]
  def change
    # If you had any ActiveStorage-related columns, remove them here.
    # For example:
    remove_column :products, :image_url_attachment, :string
    remove_column :products, :image_url_blob, :string
  end
end
