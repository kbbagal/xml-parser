def prepare_shipement_data(xml_input)
  shipment_service = $shipment.css("Service")
  shipment_data = get_empty_hash
  shipment_data['shipper_number'] = $shipment.css("ShipperNumber").inner_text
  shipment_data['service_code'] = shipment_service.css("Code").inner_text
  shipment_data['service_description'] = shipment_service.css("Description").inner_text
  shipment_data['shipment_id'] = $shipment.css("ShipmentIdentificationNumber").inner_text
  shipment_data['pickup_date'] = $shipment.css("PickupDate").inner_text

  return shipment_data
end

def prepare_shipment_address_data(shipment_id)
  ship_to_address = $shipment.css('ShipTo').css('Address')
  shipment_address = Hash.new
  shipment_address['shipment_id'] = shipment_id
  shipment_address['city'] = ship_to_address.css('City').inner_text
  shipment_address['state'] = ship_to_address.css('StateProvinceCode').inner_text
  shipment_address['postal_code'] = ship_to_address.css('PostalCode').inner_text
  shipment_address['country_code'] = ship_to_address.css('CountryCode').inner_text

  return shipment_address
end

def prepare_shipment_references_data(shipment_id)
  references = Array.new
  $shipment.css('ReferenceNumber').each do | reference |
    current_reference = Hash.new
    current_reference['shipment_id'] = shipment_id
    current_reference['reference_code'] = reference.css('Code').inner_text
    current_reference['reference_value'] = reference.css('Value').inner_text
    references << current_reference
  end

  return references
end

def prepare_shipement_packages_data(package, shipment_id)
  current_package = get_empty_hash
  current_package['shipment_id'] = shipment_id
  current_package['tracking_number'] = package.css('TrackingNumber').inner_text
  current_package['weight'] = package.css('PackageWeight').css('Weight').inner_text
  current_package['weight_in'] = package.css('UnitOfMeasurement').css('Code').inner_text

  return current_package
end

def prepare_shipement_packages_activities_data(package, package_id)
  current_package_activities = Array.new
  package.css('Activity').each do | activity |
    current_activity = get_empty_hash
    current_activity['package_id'] = package_id    
    current_activity['city'] = activity.css('ActivityLocation').css('Address').css('City').inner_text
    current_activity['state'] = activity.css('ActivityLocation').css('Address').css('StateProvinceCode').inner_text
    current_activity['postal_code'] = activity.css('ActivityLocation').css('Address').css('PostalCode').inner_text
    current_activity['country_code'] = activity.css('ActivityLocation').css('Address').css('CountryCode').inner_text
    current_activity['location_code'] = activity.css('ActivityLocation').css('Code').inner_text
    current_activity['description'] = activity.css('ActivityLocation').css('Description').inner_text
    current_activity['status_type_code'] = activity.css('ActivityLocation').css('Status').css('StatusType').css('Code').inner_text
    current_activity['status_type_description'] = activity.css('ActivityLocation').css('Status').css('StatusType').css('Description').inner_text
    current_activity['status_code'] = activity.css('Status').css('Code').inner_text
    current_activity['activity_date'] = activity.css('Date').inner_text
    current_activity['activity_time'] = activity.css('Time').inner_text
    current_package_activities << current_activity
  end

  return current_package_activities
end