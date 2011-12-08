require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test "csv import process" do
    visit(product_csv_import_upload_path)
    attach_file('file', File.expand_path("../../support/test_csv.csv/", __FILE__))
    click_button 'csv_submit'
    assert File.exists?(File.expand_path("../../dummy/tmp/test_csv.csv/",__FILE__))
    select 'Description', :from => 'attributes[description]'
    select 'Price', :from => 'attributes[price]'
    select 'Name', :from => 'attributes[name]'
    click_button 'mapping_submit'
    assert Product.last.name = 'Test'
    assert !File.exists?(File.expand_path("../../dummy/tmp/test_csv.csv/",__FILE__))
  end
end
