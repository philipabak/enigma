namespace :db do
  desc "Populate data"
  task :populate => :environment do
    branches = ['plant', 'construction', 'waste management', 'utilities', 'construction', 'road transport', 'agricultural', 'plant']
    (0..7).each do |i|
      case_study = CaseStudy.create(
        company: 'Company name',
        branch: branches[i],
        body: FFaker::Lorem.paragraph(30),
        feedback: FFaker::Lorem.paragraph(10),
        feedbacker_name: FFaker::Name.name,
        job: FFaker::Job.title,
        image: File.open(Rails.root.join('app', 'assets', 'images', "gallery-#{i+1}.jpg"))
      )
    end
  end
end