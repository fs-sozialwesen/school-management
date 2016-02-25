module SchoolManagement
  class Application < Rails::Application
    config.before_configuration do
      env_file = Rails.root.join('config', 'environment_variables.yml').to_s
      YAML.load_file(env_file).each { |key, value| ENV[key.to_s] = value }
    end unless Rails.env.test?
  end
end
