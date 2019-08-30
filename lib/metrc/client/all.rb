module Metrc
  class Client
    module All

      ENDPOINTS = %w( get_facilities_v1
                      get_harvests_v1_{id}
                      get_harvests_v1_active
                      get_harvests_v1_onhold
                      get_harvests_v1_inactive
                      get_harvests_v1_waste_types
                      get_items_v1_{id}
                      get_items_v1_active
                      get_items_v1_categories
                      get_items_v1_brands
                      get_labtests_v1_states
                      get_labtests_v1_types
                      get_packages_v1_{id}
                      get_packages_v1_{label}
                      get_packages_v1_active
                      get_packages_v1_onhold
                      get_packages_v1_inactive
                      get_packages_v1_types
                      get_packages_v1_adjust_reasons
                      get_plantbatches_v1_{id}
                      get_plantbatches_v1_active
                      get_plantbatches_v1_inactive
                      get_plantbatches_v1_types
                      get_plants_v1_{id}
                      get_plants_v1_{label}
                      get_plants_v1_vegetative
                      get_plants_v1_flowering
                      get_plants_v1_onhold
                      get_plants_v1_inactive
                      get_plants_v1_additives
                      get_plants_v1_growthphases
                      get_plants_v1_additives_types
                      get_plants_v1_waste_methods
                      get_plants_v1_waste_reasons
                      get_rooms_v1_{id}
                      get_rooms_v1_active
                      get_sales_v1_customertypes
                      get_sales_v1_receipts
                      get_sales_v1_receipts_{id}
                      get_sales_v1_transactions
                      get_sales_v1_transactions_{date}
                      get_sales_v1_transactions_{sales_date_start}_{sales_date_snd}
                      get_strains_v1_{id}
                      get_strains_v1_active
                      get_transfers_v1_incoming
                      get_transfers_v1_outgoing
                      get_transfers_v1_rejected
                      get_transfers_v1_{id}_deliveries
                      get_transfers_v1_delivery_{id}_packages
                      get_transfers_v1_delivery_{id}_packages_wholesale
                      get_transfers_v1_delivery_package_{id}_requiredlabtestbatches
                      get_transfers_v1_delivery_packages_states
                      get_transfers_v1_templates
                      get_transfers_v1_templates_{id}_deliveries
                      get_transfers_v1_templates_delivery_{id}_packages
                      get_transfers_v1_types
                      get_unitsofmeasure_v1_active
                      post_harvests_v1_create_packages
                      post_harvests_v1_removewaste
                      post_harvests_v1_finish
                      post_harvests_v1_unfinish
                      post_items_v1_create
                      post_items_v1_update
                      post_labtests_v1_record
                      post_packages_v1_create
                      post_packages_v1_create_testing
                      post_packages_v1_create_plantings
                      post_packages_v1_change_item
                      post_packages_v1_change_rooms
                      post_packages_v1_adjust
                      post_packages_v1_finish
                      post_packages_v1_unfinish
                      post_packages_v1_remediate
                      post_plantbatches_v1_createplantings
                      post_plantbatches_v1_createpackages
                      post_plantbatches_v1_changegrowthphase
                      post_plantbatches_v1_additives
                      post_plantbatches_v1_destroy
                      post_plants_v1_moveplants
                      post_plants_v1_changegrowthphases
                      post_plants_v1_destroyplants
                      post_plants_v1_additives
                      post_plants_v1_additives_byroom
                      post_plants_v1_create_plantings
                      post_plants_v1_manicureplants
                      post_plants_v1_harvestplants
                      post_rooms_v1_create
                      post_rooms_v1_update
                      post_sales_v1_receipts
                      post_sales_v1_transactions_{date}
                      post_strains_v1_create
                      post_strains_v1_update
                      post_transfers_v1_external_incoming
                      post_transfers_v1_templates
                      put_transfers_v1_templates
                      put_harvests_v1_move
                      put_plantbatches_v1_moveplantbatches
                      put_sales_v1_receipts
                      put_sales_v1_transactions_{date}
                      put_transfers_v1_external_incoming
                      delete_items_v1_{id}
                      delete_rooms_v1_{id}
                      delete_sales_v1_receipts_{id}
                      delete_strains_v1_{id}
                      delete_transfers_v1_external_incoming_{id}
                      delete_transfers_v1_templates_{id} )

      ENDPOINTS.each do |method_name|
        formatted_method_name = method_name.gsub('/', '_')
        method_name_array = method_name.split("_")
        request_type = method_name_array.shift.to_sym
        method_name = method_name_array.join("_").gsub('_', '/')

        define_method(formatted_method_name) do |user_api_key, options = {}|
          request(request_type, method_name, user_api_key, options)
        end
      end

      extend self
    end
  end
end