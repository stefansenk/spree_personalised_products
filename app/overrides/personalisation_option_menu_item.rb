
Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
                     :name => "personalisation_option_menu_item",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :partial => "spree/admin/personalisation_options/product_menu_item",
                     :disabled => false)
					# :original => '' # TODO
