
Deface::Override.new(:virtual_path => "spree/admin/shared/_order_details",
                     :name => "admin_line_item_personalisation",
                     :insert_bottom => "[data-hook='order_details_line_item_row'] td:nth-child(1)",
                     :partial => "spree/admin/orders/line_item_personalisation",
                     :disabled => false)
					# :original => '' # TODO

Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "line_item_personalisation",
                     :insert_bottom => "[data-hook='cart_item_description']",
                     :partial => "spree/orders/line_item_personalisation",
                     :disabled => false)
					# :original => '' # TODO
