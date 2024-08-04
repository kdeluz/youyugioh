ActiveAdmin.register Product do
    permit_params :name, :fname, :card_id, :konami_id, :card_type, :atk, :def, :level, :race, 
                  :card_attribute, :linkmarker, :scale, :cardset, :archetype, :banlist, :format,
                  :staple, :has_effect, :startdate, :enddate, :dateregion, :description, :price, :sale, :image_url
  
    index do
      selectable_column
      id_column
      column :name
      column :fname
      column :card_id
      column :konami_id
      column :card_type
      column :atk
      column :def
      column :level
      column :race
      column :card_attribute
      column :linkmarker
      column :scale
      column :cardset
      column :archetype
      column :banlist
      column :format
      column :staple
      column :has_effect
      column :startdate
      column :enddate
      column :dateregion
      column :description
      column :price
      column :sale
      column :image_url
      actions
    end
  
    form do |f|
      f.inputs "Product Details" do
        f.input :name
        f.input :fname
        f.input :card_id
        f.input :konami_id
        f.input :card_type
        f.input :atk
        f.input :def
        f.input :level
        f.input :race
        f.input :card_attribute
        f.input :linkmarker
        f.input :scale
        f.input :cardset
        f.input :archetype
        f.input :banlist
        f.input :format
        f.input :staple
        f.input :has_effect
        f.input :startdate, as: :datepicker
        f.input :enddate, as: :datepicker
        f.input :dateregion
        f.input :description
        f.input :price
        f.input :sale
        f.input :image_url
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :name
        row :fname
        row :card_id
        row :konami_id
        row :card_type
        row :atk
        row :def
        row :level
        row :race
        row :card_attribute
        row :linkmarker
        row :scale
        row :cardset
        row :archetype
        row :banlist
        row :format
        row :staple
        row :has_effect
        row :startdate
        row :enddate
        row :dateregion
        row :description
        row :price
        row :sale
        row :image_url
      end
      active_admin_comments
    end
  
    filter :name
    filter :card_id
    filter :konami_id
    filter :card_type
    filter :atk
    filter :def
    filter :level
    filter :race
    filter :card_attribute
    filter :linkmarker
    filter :scale
    filter :cardset
    filter :archetype
    filter :banlist
    filter :format
    filter :staple
    filter :has_effect
    filter :startdate
    filter :enddate
    filter :dateregion
    filter :description
    filter :price
    filter :sale
  end
  