require 'test/helper'

class ConfigurationTest < ActiveSupport::TestCase

  def test_should_verify_application_wide_configuration_options
    initializer = "#{Rails.root}/config/initializers/typus.rb"
    unless File.exists?(initializer)
      assert_equal 'Typus', Typus::Configuration.options[:app_name]
      assert_equal 'vendor/plugins/typus/test/config/working', Typus::Configuration.options[:config_folder]
      assert_equal 'admin@example.com', Typus::Configuration.options[:email]
      assert_equal [ [ "English", :en] ], Typus::Configuration.options[:locales]
      assert_equal false, Typus::Configuration.options[:recover_password]
      assert_equal 'admin', Typus::Configuration.options[:root]
      assert_equal false, Typus::Configuration.options[:ssl]
      assert_equal 'admin/templates', Typus::Configuration.options[:templates_folder]
      assert_equal 'TypusUser', Typus::Configuration.options[:user_class_name]
      assert_equal 'typus_user_id', Typus::Configuration.options[:user_fk]
    else
      assert Typus::Configuration.respond_to?(:options)
    end
  end

  def test_should_verify_model_configuration_options
    initializer = "#{Rails.root}/config/initializers/typus.rb"
    unless File.exists?(initializer)
      assert_equal true, Typus::Configuration.options[:edit_after_create]
      assert_equal nil, Typus::Configuration.options[:end_year]
      assert_equal 10, Typus::Configuration.options[:form_rows]
      assert_equal true, Typus::Configuration.options[:icon_on_boolean]
      assert_equal 5, Typus::Configuration.options[:minute_step]
      assert_equal 'nil', Typus::Configuration.options[:nil]
      assert_equal 15, Typus::Configuration.options[:per_page]
      assert_equal 10, Typus::Configuration.options[:sidebar_selector]
      assert_equal nil, Typus::Configuration.options[:start_year]
      assert_equal true, Typus::Configuration.options[:toggle]
    else
      assert Typus::Configuration.respond_to?(:options)
    end
  end

  def test_should_verify_options_which_are_only_overwrittable_from_environments
    assert_equal true, Typus::Configuration.options[:ignore_missing_translations]
    assert_equal 'typus', Typus::Configuration.options[:path_prefix]
  end

  def test_should_verify_typus_roles_is_loaded
    assert Typus::Configuration.respond_to?(:roles!)
    assert Typus::Configuration.roles!.kind_of?(Hash)
  end

  def test_should_verify_typus_config_file_is_loaded
    assert Typus::Configuration.respond_to?(:config!)
    assert Typus::Configuration.config!.kind_of?(Hash)
  end

  def test_should_load_configuration_files_from_config_broken
    options = { :config_folder => 'vendor/plugins/typus/test/config/broken' }
    Typus::Configuration.stubs(:options).returns(options)
    assert_not_equal Hash.new, Typus::Configuration.roles!
    assert_not_equal Hash.new, Typus::Configuration.config!
  end

  def test_should_load_configuration_files_from_config_empty
    options = { :config_folder => 'vendor/plugins/typus/test/config/empty' }
    Typus::Configuration.stubs(:options).returns(options)
    assert_equal Hash.new, Typus::Configuration.roles!
    assert_equal Hash.new, Typus::Configuration.config!
  end


  def test_should_load_configuration_files_from_config_ordered
    options = { :config_folder => 'vendor/plugins/typus/test/config/ordered' }
    Typus::Configuration.stubs(:options).returns(options)
    files = Dir["#{Rails.root}/#{Typus::Configuration.options[:config_folder]}/*_roles.yml"]
    expected = files.collect { |file| File.basename(file) }
    assert_equal expected, ['001_roles.yml', '002_roles.yml']
    expected = { 'admin' => { 'categories' => 'read' } }
    assert_equal expected, Typus::Configuration.roles!
  end

  def test_should_load_configuration_files_from_config_unordered
    options = { :config_folder => 'vendor/plugins/typus/test/config/unordered' }
    Typus::Configuration.stubs(:options).returns(options)
    files = Dir["#{Rails.root}/#{Typus::Configuration.options[:config_folder]}/*_roles.yml"]
    expected = files.collect { |file| File.basename(file) }
    assert_equal expected, ['app_one_roles.yml', 'app_two_roles.yml']
    expected = { 'admin' => { 'categories' => 'read, update' } }
    assert_equal expected, Typus::Configuration.roles!
  end

  def test_should_load_configuration_files_from_config_default
    options = { :config_folder => 'vendor/plugins/typus/test/config/default' }
    Typus::Configuration.stubs(:options).returns(options)
    assert_not_equal Hash.new, Typus::Configuration.roles!
    assert_not_equal Hash.new, Typus::Configuration.config!
    assert Typus.resources.empty?
  end

end