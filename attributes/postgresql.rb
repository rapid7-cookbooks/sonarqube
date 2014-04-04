# The sonar agent connects directly to the postgresql database.
# It is not recommended you change this value.
override['postgresql']['config']['listen_addresses'] = '0.0.0.0'
