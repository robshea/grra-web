<style type="text/css">
	div#invoiceTopMessageHeaderId 
	{
		font-size: 1.0em;
	}
</style>
<$control.Form(formBegin = "true", action = Model.Urls.FinDocumentAction, id = "idMemberInvoiceDetailsForm", class="paymentDetailsForm", target=Model.SubmitFormTarget)$>
  <h1 class="pageTitle SystemPageTitle">
	  <$Model.InvoiceDetails.Title$>
	</h1>

	<div id="topMessageBoxDiv">
    <$if (Model.DisplayPaymentInfoMessageBoxBool)$>
      <$if (Model.DisplayPaymentSuccessMessageBool)$>
        <$control.MessageBox(Text=Model.PaymentInfoMessages, Success="True")$>
      <$else$>
        <$control.MessageBox(Text=Model.PaymentInfoMessages, Error="True")$>
      <$endif$>
    <$endif$>
    <$if (Model.InvoiceDetails.IsBalanceDue)$>
      <$InvoiceWarning(HeaderSpanId="invoiceTopMessageHeaderId", HeaderText=Model.InvoiceDetails.TopMessageBoxHeader, Text=InvoiceWarningText())$>
    <$endif$>
	</div>
  <div class="formContainer">
		<div class="generalFieldsContainer">
      <$control.FormHelpers(caption="true", name=Model.InvoiceDetails.Text.InvoiceDetailsLabel)$>
      <$control.FormHelpers(sectionStart="true")$>

      <div class="fieldContainer simpleTextContainer">
        <div class="fieldSubContainer labeledTextContainer">
          <div class="fieldLabel">
            <span <$if (Model.InvoiceDetails.IsBalanceDue)$> class="warning"<$endif$>>
              <$Model.InvoiceDetails.Text.BalanceDueLabel$>
            </span>
          </div>
          <div class="fieldBody">
            <span  <$if (Model.InvoiceDetails.IsBalanceDue)$>class="warning"<$endif$>>
              <$Model.InvoiceDetails.BalanceDue$>
              <$if (Model.InvoiceDetails.IsLastPaymentFailed)$>
                <div style="font-weight: normal;">
                  <$Model.InvoiceDetails.LastInvoicePaymentFailed$>
                </div>
              <$endif$>
            </span>
          </div>
        </div>
      </div>

      <div class="fieldContainer simpleTextContainer">
        <div class="fieldSubContainer labeledTextContainer">
          <div class="fieldLabel">
            <span>
              <$Model.Text.AmountLabel$>
            </span>
          </div>

          <div class="fieldBody">
            <span>
              <$Model.InvoiceDetails.Amount$>
              <$if (Model.InvoiceDetails.ShowPaymentDocument)$>
                <$if (Model.InvoiceDetails.IsInvoicePaid)$>
                  <$Model.InvoiceDetails.PaymentsDocument:{<div><a href="<$it.DocumentUrl$>"><$it.DocumentName$></a></div>}$>
                <$endif$>
              <$endif$>
            </span>
          </div>
        </div>
      </div>

      <$control.FormHelpers (simpleText="true", name=Model.InvoiceDetails.Text.InvoiceNumberLabel, value=Model.InvoiceDetails.Number)$>
      <$control.FormHelpers (simpleText="true", name=Model.InvoiceDetails.Text.DateLabel, value=Model.InvoiceDetails.Date)$>

      <div class="fieldContainer simpleTextContainer">
        <div class="fieldSubContainer labeledTextContainer">
          <div class="fieldLabel">
            <span><$Model.InvoiceDetails.Text.InvoiceOriginLabel$></span>
          </div>

          <div class="fieldBody">
            <span>
              <$if (Model.InvoiceDetails.ShowOriginLink)$>
                <$if (Model.InvoiceDetails.DisableOriginLink)$>
                  <$Model.InvoiceDetails.OriginText$> <$Model.InvoiceDetails.Text.OriginContact$>
                <$else$>
                  <a href="<$Model.InvoiceDetails.OriginLink$>"><$Model.InvoiceDetails.OriginText$></a> <$Model.InvoiceDetails.Text.OriginContact$>
                <$endif$>
              <$else$>
                <$Model.InvoiceDetails.OriginText$> <$Model.InvoiceDetails.Text.EventRegistrationContact$>
              <$endif$>
              <div>
                <$Model.InvoiceDetails.OriginDetails$>
              </div>
            </span>
          </div>
        </div>
      </div>

      <div class="fieldContainer simpleTextContainer">
        <div class="fieldSubContainer labeledTextContainer">
          <div class="fieldLabel">
            <span><$Model.InvoiceDetails.Text.InvoiceToLabel$></span>
          </div>

          <div class="fieldBody">
            <span>
              <$if (Model.InvoiceDetails.InvoiceToFullNameIsEmpty)$>
                <$Model.InvoiceDetails.InvoiceToEmail$>
              <$else$>
                <$Model.InvoiceDetails.InvoiceTo$>
                <br />
                <$Model.InvoiceDetails.InvoiceToEmail$>
              <$endif$>
            </span>
          </div>
        </div>
      </div>

      <$if (Model.InvoiceDetails.MemoIsNotEmpty)$>
        <$control.FormHelpers(simpleText="true", name=Model.InvoiceDetails.Text.MemoLabel, value=Model.InvoiceDetails.Memo)$>
      <$endif$>

      <$control.FormHelpers(sectionEnd="true")$>
		</div>
	</div>

	<table cellspacing="0" class="membersTable" id="membersTable">
    <thead>
      <tr>
        <th class="memberDirectoryColumn1" colspan="2">
          <$Model.InvoiceDetails.Text.InvoiceItemsHeaderColumnLabel$>
        </th>
        <th style="" class="memberDirectoryColumn3 right">
          <$Model.InvoiceDetails.Text.InvoiceAmountHeaderColumnLabel$>
        </th>
      </tr>
    </thead>
    <tbody>
      <$Model.InvoiceDetails.SalesItems:
      {                
        <tr>
          <td class="memberDirectoryColumn1" colspan="2">
            <$it.Name$>
          </td>
          <td class="memberDirectoryColumn3 right">
            <$it.Amount$>
          </td>
        </tr>
      }
      $>

      <$if (Model.InvoiceDetails.ShowTaxes)$>
        <tr>
          <td class="memberDirectoryColumn1"></td>
          <$if (Model.InvoiceDetails.ShowSubtotal)$>
            <td class="memberDirectoryColumn2 right">
              <$Model.InvoiceDetails.Text.InvoiceAmountSubtotalLabel$>
            </td>
            <td class="memberDirectoryColumn3 right">
              <$Model.InvoiceDetails.Subtotal$>
            </td>
          <$else$>
            <td class="memberDirectoryColumn2 right">
              <$Model.InvoiceDetails.Text.InvoiceAmountTotalLabel$>
            </td>
            <td class="memberDirectoryColumn3 right">
              <$Model.InvoiceDetails.Amount$>
            </td>
          <$endif$>
        </tr>

        <$Model.InvoiceDetails.Taxes:
        {
          <tr>
            <td class="memberDirectoryColumn1 noSeparator"></td>
            <td class="memberDirectoryColumn2 right noSeparator">
              <$it.TaxName$>
            </td>
            
            <td class="memberDirectoryColumn3 right noSeparator">
              <$it.TaxAmount$>  
            </td>
          </tr>
        }
        $>

        <$if (Model.InvoiceDetails.ShowSubtotal)$>
          <tr>
            <td class="memberDirectoryColumn1 noSeparator"></td>
            <td class="memberDirectoryColumn2 right noSeparator">
              <$Model.InvoiceDetails.Text.InvoiceAmountTotalLabel$>
            </td>

            <td class="memberDirectoryColumn3 right noSeparator">
              <$Model.InvoiceDetails.Amount$>  
            </td>
          </tr>
        <$endif$>  

      <$else$>    
        <tr>
          <td class="memberDirectoryColumn1 right" colspan="2">
            <$Model.InvoiceDetails.Text.InvoiceAmountTotalLabel$>
          </td>

          <td class="memberDirectoryColumn3 right">
            <$Model.InvoiceDetails.Amount$>
          </td>
        </tr>
      <$endif$>   

    </tbody>        
	</table>
<$control.Form(formEnd = "true")$>

<script language="javascript">
(function ()
{
    if (!window.InvoiceDetailsRenderer)
    {
        window.InvoiceDetailsRenderer = {};
    }	

    InvoiceDetailsRenderer.PayButtonsMessageBoxGroup = document.getElementById('payButtonsMessageBoxGroup');

    InvoiceDetailsRenderer.Labels =
    {    
      PleaseWaitText: '<$Model.InvoiceDetails.Text.PleaseWaitText$>'
    };

	InvoiceDetailsRenderer.PreventNewWindow = function()
	{
      var form = document.getElementById('idMemberInvoiceDetailsForm');
      if (form == null)
      {
        return;
      }

	  form.target = "";
	}

    InvoiceDetailsRenderer.DisablePaymentButtonsInWidget = function()
	{
      if (InvoiceDetailsRenderer.PayButtonsMessageBoxGroup)
      {
        var content = document.createElement('DIV');
        var a = new Array();
        a.push(InvoiceDetailsRenderer.Labels.PleaseWaitText);
        content.innerHTML = a.join('');

        var inputs = InvoiceDetailsRenderer.PayButtonsMessageBoxGroup.getElementsByTagName("input");
        for (var i = 0; i < inputs.length; i++) 
        {
            inputs[i].style.display='none';
        }

        InvoiceDetailsRenderer.PayButtonsMessageBoxGroup.appendChild(content);
       }      
	}    

    })();

</script>
