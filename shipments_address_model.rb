def create_shipments_address(input_data)
  insert_query = "INSERT INTO shipments_address (`shipment_id`, `city`, `state`, `postal_code`, `country_code`)
                                         VALUES ('#{input_data['shipment_id']}','#{input_data['city']}',
                                         '#{input_data['state']}','#{input_data['postal_code']}','#{input_data['country_code']}')"
  $database.execute(insert_query)
  
  return $database.last_insert_row_id
end