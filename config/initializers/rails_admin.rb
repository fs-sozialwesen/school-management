RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  config.authorize_with do |_controller|
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    # root actions:
    dashboard                     # mandatory

    # collection actions:
    index                         # mandatory
    new
    export
    history_index
    # bulk_delete

    # member actions:
    show
    edit
    delete
    history_show
    show_in_app
  end

end

RailsAdmin::Config::Fields::Types::register(:email, RailsAdmin::FieldType::EmailField)
RailsAdmin::Config::Fields::Types::register(:address, RailsAdmin::FieldType::AddressField)
