
Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "product_personalisation",
                     :insert_top => "[data-hook='product_price']",
                     :partial => "spree/products/personalisation_options",
                     :disabled => false)
					# :original => '' # TODO
