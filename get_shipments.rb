require 'nokogiri'
require 'open-uri'
require './initialize_db'
require './shipments_model'
require './shipments_references_model'
require './shipments_address_model'
require './shipments_packages_model'
require './shipments_packages_activities_model'
require './data_preparation_helper'

def fetch_xml
  begin
    xml_input = Nokogiri::XML(open(
                            "https://raw.githubusercontent.com/hautelook/shipment-tracking/master/tests/fixtures/ups.xml"
                            ))
  rescue => error
    puts "Error fetching XML data : #{error}"
  end
end

def get_empty_hash
  return Hash.new
end

xml_input = fetch_xml
$shipment = xml_input.css("Shipment")
shipment_id = create_shipment(prepare_shipement_data(xml_input))

if shipment_id
  create_shipments_address(prepare_shipment_address_data(shipment_id))
  create_shipments_references(prepare_shipment_references_data(shipment_id))
  $shipment.css('Package').each do | package |
    package_id = create_shipments_packages(prepare_shipement_packages_data(package, shipment_id))
    create_shipments_packages_activities(prepare_shipement_packages_activities_data(package, package_id))
  end
  
  puts "Shipments data imported ... "
else
  puts "Could not create new record! Aborting ...."
end