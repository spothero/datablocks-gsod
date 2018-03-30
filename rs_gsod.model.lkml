connection: "redshift_test"

include: "rs.*.view"

explore: weather {
  from: rs_gsod
  join: zipcode_station {
    from: rs_zipcode_station
    view_label: "Geography"
    type: left_outer
    relationship: many_to_one
    sql_on: ${weather.station_id} = ${zipcode_station.nearest_station_id}
      and ${weather.year} = ${zipcode_station.year};;
  }
  join: stations {
    from: rs_stations
    type: left_outer
    relationship: many_to_one
    sql_on: ${zipcode_station.nearest_station_id} = ${stations.station_id} ;;
  }
  join: zipcode_county{
    from: rs_zipcode_county
    view_label: "Geography"
    type: left_outer
    relationship: many_to_one
    sql_on: ${zipcode_station.zipcode} = ${zipcode_county.zipcode}  ;;
  }
  join: zipcode_facts {
    from: rs_zipcode_facts
    view_label: "Geography"
    type: left_outer
    relationship: one_to_many
    sql_on: ${zipcode_county.zipcode} = ${zipcode_facts.zipcode} ;;
  }
}

explore: weather_test {
  from: rs_gsod
  join: zipcode_station {
    from: rs_zipcode_station
    view_label: "Geography"
    type: left_outer
    relationship: many_to_one
    sql_on: ${weather_test.station_id} = ${zipcode_station.nearest_station_id}
      and ${weather_test.year} = ${zipcode_station.year};;
  }
}
