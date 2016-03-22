ActiveAdmin.register CaseStudy do

  permit_params :company, :branch, :body, :feedback, :feedbacker_name, :job, :image

  index do
    selectable_column
    id_column
    column :company
    column :branch
    column :feedbacker_name
    column :job
    actions
  end

  form do |f|
    f.inputs "Case Study Details" do
      f.input :company
      f.input :branch
      f.input :body, input_html: { class: 'redactor' }
      f.input :feedback
      f.input :feedbacker_name
      f.input :job
      f.input :image
    end
    f.actions
  end
end
