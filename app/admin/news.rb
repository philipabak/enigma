ActiveAdmin.register News do
  permit_params :title, :content, :published_at

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :published_at
    actions
  end

  filter :title
  filter :published_at

  form do |f|
    f.inputs "News Details" do
      f.input :title
      f.input :content, input_html: { class: 'redactor' }
      f.input :published_at
    end
    f.actions
  end

end
