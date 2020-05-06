def create_shipments_packages_activities(input_data)
  insert_query = "INSERT INTO shipments_packages_activities (`package_id`, `city`, `state`, `postal_code`,
                                                            `country_code`, `location_code`, `description`,
                                                            `status_type_code`,`status_type_description`,
                                                            `status_code`, `activity_date`, `activity_time`)
                                                          VALUES "
  input_data.each do | activity |                                                            
    insert_query += "('#{activity['package_id']}','#{activity['city']}',
                    '#{activity['state']}','#{activity['postal_code']}',
                    '#{activity['country_code']}','#{activity['location_code']}',
                    '#{activity['description']}','#{activity['status_type_code']}',
                    '#{activity['status_type_description']}','#{activity['status_code']}',
                    '#{activity['activity_date']}','#{activity['activity_time']}'),"
  end

  insert_query = insert_query.chomp(',')
  $database.execute(insert_query)
  
  return $database.last_insert_row_id
end