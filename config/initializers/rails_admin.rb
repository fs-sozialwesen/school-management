RailsAdmin.config do |config|

  config.default_items_per_page = 50
  config.label_methods = [:display_name, :name, :title] # Default is [:name, :title]

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_login)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'Login', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.authorize_with do |_controller|
    redirect_to main_app.root_path unless current_user.try(:manager?)
  end

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    # root actions:
    dashboard                     # mandatory

    # collection actions:
    index                         # mandatory
    new           { except ['LegacyDatum'] }
    export        { except %w(LegacyDatum EducationSubject) }
    history_index { except %w(LegacyDatum EducationSubject) }
    # bulk_delete

    # member actions:
    show
    edit         { except %w(LegacyDatum EducationSubject) }
    delete       { except %w(LegacyDatum Course EducationSubject) }
    history_show { except %w(LegacyDatum EducationSubject) }
    # show_in_app { except ['LegacyDatum'] }
  end

end

RailsAdmin::Config::Fields::Types::register(:self_link, RailsAdmin::FieldType::SelfLinkField)
RailsAdmin::Config::Fields::Types::register(:email, RailsAdmin::FieldType::EmailField)
RailsAdmin::Config::Fields::Types::register(:address, RailsAdmin::FieldType::AddressField)
RailsAdmin::Config::Fields::Types::register(:metadata, RailsAdmin::FieldType::AddressField)
