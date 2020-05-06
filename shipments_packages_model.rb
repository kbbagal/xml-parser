def create_shipments_packages(input_data)
  insert_query = "INSERT INTO shipments_packages (`shipment_id`, `tracking_number`, `weight`, `weight_in`)
                                         VALUES ('#{input_data['shipment_id']}','#{input_data['tracking_number']}',
                                         '#{input_data['weight']}','#{input_data['weight_in']}')"
  $database.execute(insert_query)
  
  return $database.last_insert_row_id
end