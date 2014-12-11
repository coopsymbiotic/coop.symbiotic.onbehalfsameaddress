
{* code taken from civicrm templates/CRM/Core/BillingBlock with a few modification to make it work with onbehalf profile *}

{if $onbehalfProfileAddressFields}
     <script type="text/javascript">
     {literal}

cj( function( ) {

  // add checkbox
  var cb = {/literal}'<input type="checkbox" id="billingcheckbox" value="0"> <label for="billingcheckbox">{ts}My billing address is the same as above{/ts}</label>'{literal};
  cj('.billing_name_address-group').before(cb);

  // build list of ids to track changes on
  var address_fields = {/literal}{$onbehalfProfileAddressFields|@json_encode}{literal};
  var input_ids = {};
  var select_ids = {};
  var orig_id = field = field_name = null;

  // build input ids
  cj('.billing_name_address-section input').each(function(i){
    orig_id = cj(this).attr('id');
    field = orig_id.split('-');
    field_name = 'onbehalf_'+field[0].replace('billing_', '');
    if(field[1]) {
      if(address_fields[field_name]) {
        input_ids['#'+field_name+'-'+address_fields[field_name]] = '#'+orig_id;
      }
    }
  });
  if(cj('#first_name').length)
    input_ids['#first_name'] = '#billing_first_name';
  if(cj('#middle_name').length)
    input_ids['#middle_name'] = '#billing_middle_name';
  if(cj('#last_name').length)
    input_ids['#last_name'] = '#billing_last_name';

  // build select ids
  cj('.billing_name_address-section select').each(function(i){
    orig_id = cj(this).attr('id');
    field = orig_id.split('-');
    field_name = 'onbehalf_'+field[0].replace('billing_', '').replace('_id', '');
    if(field[1]) {
      if(address_fields[field_name]) {
        select_ids['#'+field_name+'-'+address_fields[field_name]] = '#'+orig_id;
      }
    }
  });

  // detect if billing checkbox should default to checked
  var checked = true;
  for(var id in input_ids) {
    var orig_id = input_ids[id];
    if(cj(id).val() != cj(orig_id).val()) {
      checked = false;
      break;
    }
  }
  for(var id in select_ids) {
    var orig_id = select_ids[id];
    if(cj(id).val() != cj(orig_id).val()) {
      checked = false;
      break;
    }
  }

  if(checked) {
    cj('#billingcheckbox').attr('checked', 'checked');
    cj('.billing_name_address-group').hide();
  }

  // onchange handlers for non-billing fields
  for(var id in input_ids) {
    var orig_id = input_ids[id];
    cj(id).change(function(){
      var id = '#'+cj(this).attr('id');
      var orig_id = input_ids[id];

      // if billing checkbox is active, copy other field into billing field
      if(cj('#billingcheckbox').attr('checked')) {
        cj(orig_id).val( cj(id).val() );
      };
    });
  };
  for(var id in select_ids) {
    var orig_id = select_ids[id];
    cj(id).change(function(){
      var id = '#'+cj(this).attr('id');
      var orig_id = select_ids[id];

      // if billing checkbox is active, copy other field into billing field
      if(cj('#billingcheckbox').attr('checked')) {
        cj(orig_id+' option').removeAttr('selected');
        cj(orig_id+' option[value="'+cj(id).val()+'"]').attr('selected', 'selected');
      };

      if(orig_id == '#billing_country_id-5') {
        cj(orig_id).change();
      }
    });
  };


  // toggle show/hide
  cj('#billingcheckbox').click(function(){
    if(this.checked) {
      cj('.billing_name_address-group').hide(200);

      // copy all values
      for(var id in input_ids) {
        var orig_id = input_ids[id];
        cj(orig_id).val( cj(id).val() );
      };
      for(var id in select_ids) {
        var orig_id = select_ids[id];
        cj(orig_id+' option').removeAttr('selected');
        cj(orig_id+' option[value="'+cj(id).val()+'"]').attr('selected', 'selected');
      };
    } else {
      cj('.billing_name_address-group').show(200);
    }
  });

  // remove spaces, dashes from credit card number
  cj('#credit_card_number').change(function(){
    var cc = cj('#credit_card_number').val()
      .replace(/ /g, '')
      .replace(/-/g, '');
    cj('#credit_card_number').val(cc);
  });


});

     {/literal}
     </script>

{/if}

