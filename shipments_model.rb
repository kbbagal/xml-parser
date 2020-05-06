def create_shipment(input_data)
  insert_query = "INSERT INTO shipments (`shipper_number`, `service_code`, `service_description`,
                                         `shipment_id`, `pickup_date`) 
                                         VALUES ('#{input_data['shipper_number']}','#{input_data['service_code']}',
                                         '#{input_data['service_description']}','#{input_data['shipment_id']}',
                                         '#{input_data['pickup_date']}')"
  $database.execute(insert_query)
  return $database.last_insert_row_id
end