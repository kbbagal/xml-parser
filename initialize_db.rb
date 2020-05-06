require 'sqlite3'
$database = nil
begin
  $database = SQLite3::Database.new 'shipping_db'
  puts $database.get_first_value 'SELECT SQLITE_VERSION()'
    
rescue SQLite3::Exception => e 
  puts "Exception occurred"
  puts e
end

def create_shipments_table
  query_to_create_table = "CREATE TABLE IF NOT EXISTS shipments (
    id integer primary key,
    shipper_number integer,
    service_code string(10),
    service_description string(10),
    shipment_id string(10),
    pickup_date datetime
  )"

  $database.execute(query_to_create_table)

end

def create_shipments_references_table
  query_to_create_table = "CREATE TABLE IF NOT EXISTS shipments_references (
    id integer primary key,
    shipment_id integer,
    reference_code string(10),
    reference_value string(10)
  )"

  $database.execute(query_to_create_table)

end

def create_shipments_address_table
  query_to_create_table = "CREATE TABLE IF NOT EXISTS shipments_address (
    id integer primary key,
    shipment_id integer,
    city string(10),
    state string(10),
    postal_code integer,
    country_code string(2)
  )"

  $database.execute(query_to_create_table)

end

def create_package_table
  query_to_create_table = "CREATE TABLE IF NOT EXISTS shipments_packages (
    id integer primary key,
    shipment_id integer,
    tracking_number string(128),
    weight float,
    weight_in string(10)
    )"

  $database.execute(query_to_create_table)

end

def create_packages_activities_table
  query_to_create_table = "CREATE TABLE IF NOT EXISTS shipments_packages_activities (
    id integer primary key,
    package_id integer,
    city string(10),
    state string(10),
    postal_code integer,
    country_code string(2),
    location_code string(2),
    description string(2),
    status_type_code string(2),
    status_type_description string(128),
    status_code string(2),
    activity_date date,
    activity_time time    
    )"

  $database.execute(query_to_create_table)
  
end

create_shipments_table
create_shipments_references_table
create_shipments_address_table
create_package_table
create_packages_activities_table