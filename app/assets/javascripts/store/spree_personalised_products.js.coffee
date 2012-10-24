//= require store/spree_core

$ -> 
  $('#product-variants input').click ->
    $('#product_personalisation_options ul.personalisation_options_variant').hide()
    $('#product_personalisation_options ul.personalisation_options_variant input').prop('disabled', true)
    $('#personalisation_options_variant_' + this.value).show()
    $('#personalisation_options_variant_' + this.value + ' input').prop('disabled', false)
  $('#product-variants input').first().click()

