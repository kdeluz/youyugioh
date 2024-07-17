ActiveAdmin.register ContactPage do
  permit_params :content

  form do |f|
    f.inputs do
      f.input :content, as: :quill_editor
    end
    f.actions
  end
end
