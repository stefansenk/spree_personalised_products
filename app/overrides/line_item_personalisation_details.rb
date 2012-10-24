
Deface::Override.new(:virtual_path => "spree/admin/orders/_line_item",
                     :name => "admin_line_item_personalisation",
                     :insert_bottom => "[data-hook='admin_order_form_line_item_row'] td:nth-child(1)",
                     :partial => "spree/admin/orders/line_item_personalisation",
                     :disabled => false)
					# :original => '' # TODO

Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "line_item_personalisation",
                     :insert_bottom => "[data-hook='cart_item_description']",
                     :partial => "spree/orders/line_item_personalisation",
                     :disabled => false)
					# :original => '' # TODO
