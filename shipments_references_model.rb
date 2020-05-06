def create_shipments_references(input_data)
  insert_query = "INSERT INTO shipments_references (`shipment_id`, `reference_code`, `reference_value`)
                                         VALUES "
  input_data.each do | reference |            
    insert_query += "('#{reference['shipment_id']}','#{reference['reference_code']}',
    '#{reference['reference_value']}'),"
  end
  insert_query = insert_query.chomp(',')
  $database.execute(insert_query)

  return $database.last_insert_row_id
end