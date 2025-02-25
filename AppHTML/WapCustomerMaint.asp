<% Response.ContentType = "text/vnd.wap.wml"%><?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">

<%
   ' This sample, WapCustomerMaint.asp, and its complement, WapCustList.asp were created using the WAP
   ' entry and report wizard. These two wizards are designed to work together providing a simple
   ' model for displaying lists of data, displaying "form" information for each line of data, and
   ' for editing the data. It's not easy to add, edit and deletes customers from a cell phone, but
   ' with a little practice it can be done.
   '
   ' This is 100% wizard generated except for additonal comments that have been added to the page
   '
   ' This uses the WBO oWapCustomerMaint (WapCustomerMaint.wbo). Note that we could have used the same
   ' WBO we use for HTML data entry and display. WML and HTML pages can share the same WBOs (after all
   ' the business logic is the same for both).
%>

<% '
   '  Wap Customer Entry and Maintenance
   '
   'Initialize Standard Information

   ' Action = Save|Edit|Delete|Prev|Next|Find|Last|First
   '      Determines what to do with this request
   Action=request("Action")


   ' Index to use for finding records or display the list
   Index  = Request("Index")
   if Index = "" then Index = 1

   ' The name of the List page to be used in conjunction with this page
   ListURL   = "WapCustList.asp" ' name of list file. If blank none.

   ' Name of this URL
   Url = Request.ServerVariables("URL")

   SaveError = False

   ' This is the ID of the current record we are working with
   '
   RowId=request("RowId")

   ' Some devices have problems with Posted data. If a request URL is the same as the current URL and
   ' there is no querystring information (i.e. all data is POSTed) the device assumes it can ignore
   ' request because the data is cached. It's not. So we generate a random number and pass that on
   ' the query string - force the cache to be ignored
   Randomize:   RID=int(Rnd * 1000)
%>

<wml>
<head>
    <meta forua="true" http-equiv="Cache-Control" content="must-revalidate"/>
</head>
<!-- #INCLUDE FILE="inc/ddValue_Constants.inc" -->

<card id="Card1" newcontext="true">
<p align="center">
   <b>Wap Customer Entry and Maintenance</b>
</p>
<p>
<% ' DebugMode =1 ' uncomment this for page get/post debug help %>
<!-- #INCLUDE FILE="inc/DebugHelp.inc" -->

<%
  '-----------------------------------------------------------
  ' Process passed Request Information.
  '    Initialize WBOs and perform any WBO operations required
  '-----------------------------------------------------------

  ' if RowId<>""0, find it else if Edting do a clear, else find first record
  If RowId<>"" Then
      Err = oWapCustomerMaint.RequestFindbyRowId( "Customer", RowId)
  elseif Action="Edit" then
      Err = oWapCustomerMaint.RequestClear("Customer",1)
  else
      Err = oWapCustomerMaint.RequestFind("Customer",Index,FIRST_RECORD)
  end if
  ' process various Actions that might have been selected
  ' only support Post submissions
  If request("Request_method")="POST" Then
    oWapCustomerMaint.call "set_pbReportErrors", 0

   if Action = "Save" then
        err = oWapCustomerMaint.RequestSave("Customer")
        if err = 0 then
            Response.Write("<b><i>Customer record saved</i></b><br/>")
        else
            Response.Write("<b><i>Could not save changes. Errors Occurred</i></b><br/>")
            SaveError=True ' this tells us to use the edit screen
        end if
    end if

    if Action = "Delete"   then
        Err = oWapCustomerMaint.RequestDelete("Customer")
        if err = 0 then
           Response.Write("<b><i>The record has been deleted.</i></b><br/>")
           Action = "Next"
        else
           Response.Write("<b><i>The record could not be deleted.</i></b><br/>")
        end if
    end if

    ' note we use the Index variable we created above
    if Action = "Prev"  then  Err = oWapCustomerMaint.RequestFind("Customer", Index, LT)
    if Action = "Find"  then  Err = oWapCustomerMaint.RequestFind("Customer", Index, GE)
    if Action = "Next"  then  Err = oWapCustomerMaint.RequestFind("Customer", Index, GT)
    if Action = "First" then  Err = oWapCustomerMaint.RequestFind("Customer", Index, FIRST_RECORD)
    if Action = "Last"  then  Err = oWapCustomerMaint.RequestFind("Customer", Index, LAST_RECORD)

end if
RowId=oWapCustomerMaint.ddValue("Customer.RowId")
%>


<%
  '-----------------------------------------------------------
  ' Build WML Page Display
  '    Data has been processed, WBOs are initialized and data is loaded.
  '    now use this data to build display pages.
  '    Depending on the status of Action and the value of SaveError
  '    different types of pages will be displayed. Either a data entry
  '    page is created, or, a data display page is created.
  '-----------------------------------------------------------
%>

<% if SaveError=False AND Action<>"Edit" then %>

<%
   ' if we are not doing an edit or we don't have a save error (SaveError)
   ' we are doing a display. This is the default display mode
%>

      <b>Number</b>   <%=oWapCustomerMaint.DDValue("Customer.Customer_Number")%><br/>
      <b>Customer Name</b>   <%=oWapCustomerMaint.DDValue("Customer.Name")%><br/>
      <b>Status</b>   <%=oWapCustomerMaint.DDValue("Customer.Status")%><br/>
      <b>Address</b>   <%=oWapCustomerMaint.DDValue("Customer.Address")%><br/>
      <b>City</b>   <%=oWapCustomerMaint.DDValue("Customer.City")%><br/>
      <b>St.</b>   <%=oWapCustomerMaint.DDValue("Customer.State")%><br/>
      <b>Zip</b>   <%=oWapCustomerMaint.DDValue("Customer.Zip")%><br/>
      <b>Phone</b>   <%=oWapCustomerMaint.DDValue("Customer.Phone_Number")%><br/>
</p>

 <do type="accept" label="Next">
       <go href="<%=Url%>?Rnd=<%=RID%>" method="post">
           <postfield name="Action"  value="Next"/>
           <postfield name="Index"   value="<%=Index%>"/>
           <postfield name="customer__rowid"   value="<%=RowId%>"/>
       </go>
  </do>
  <do type="prev" label="Prev">
       <go href="<%=Url%>?Rnd=<%=RID%>" method="post">
          <postfield name="Action"  value="Prev"/>
          <postfield name="Index"   value="<%=Index%>"/>
          <postfield name="customer__rowid"   value="<%=RowId%>"/>
      </go>
  </do>

  <do type="options" label="Search/List">
      <go href="<%=ListUrl%>?RowId=<%=RowId%>&amp;Index=<%=Index%>"/>
  </do>
  <do type="option2" label="Add">
    <go href="<%=Url%>?RowId=&amp;Index=<%=Index%>&amp;Action=Edit"/>
  </do>
  <do type="option3" label="Edit">
    <go href="<%=Url%>?RowId=<%=RowId%>&amp;Index=<%=Index%>&amp;Action=Edit"/>
  </do>
  <do type="option4" label="Delete">
    <go href="<%=Url%>?RowId=<%=RowId%>&amp;Index=<%=Index%>&amp;Action=Delete"/>
  </do>

</card>

<% Else %>

  <%
     ' if here we are editing or correcting an edit. The record is already in the DD
     ' Note, if a validation error exists we show the error as part of the label
  %>
      <%FieldError=oWapCustomerMaint.DDValue("Customer.Customer_Number",DDSHORTFIELDERROR) %>
      <b>Number: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__customer_number" value="<%=oWapCustomerMaint.DDValue("Customer.Customer_Number") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.Name",DDSHORTFIELDERROR) %>
      <b>Customer Name: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__name" value="<%=oWapCustomerMaint.DDValue("Customer.Name") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.Status",DDSHORTFIELDERROR) %>
      <b>Status: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__status" value="<%=oWapCustomerMaint.DDValue("Customer.Status") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.Address",DDSHORTFIELDERROR) %>
      <b>Address: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__address" value="<%=oWapCustomerMaint.DDValue("Customer.Address") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.City",DDSHORTFIELDERROR) %>
      <b>City: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__city" value="<%=oWapCustomerMaint.DDValue("Customer.City") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.State",DDSHORTFIELDERROR) %>
      <b>St.: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__state" value="<%=oWapCustomerMaint.DDValue("Customer.State") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.Zip",DDSHORTFIELDERROR) %>
      <b>Zip: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__zip" value="<%=oWapCustomerMaint.DDValue("Customer.Zip") %>" /><br/>

      <%FieldError=oWapCustomerMaint.DDValue("Customer.Phone_Number",DDSHORTFIELDERROR) %>
      <b>Phone: </b>
      <% If FieldError<>"" then response.write("<i>(" & FieldError & ") </i>") %>
      <input name="customer__phone_number" value="<%=oWapCustomerMaint.DDValue("Customer.Phone_Number") %>" /><br/>


      <select name="action">
         <option title="Go:Discard" onpick="<%=Url%>?RowId=<%=RowId%>&amp;Index=<%=Index%>">Discard Changes</option>
         <option value="New" title="Go:Save">Save Changes</option>
      </select>

</p>

  <do type="accept" label="Save">
    <go href="<%=Url%>?Rnd=<%=RID%>" method="post">
        <postfield name="Action" value="Save"/>
        <postfield name="customer__rowid"  value="<%=RowId %>"/>
        <postfield name="customer__customer_number" value="$(customer__customer_number)"/>
        <postfield name="customer__name" value="$(customer__name)"/>
        <postfield name="customer__status" value="$(customer__status)"/>
        <postfield name="customer__address" value="$(customer__address)"/>
        <postfield name="customer__city" value="$(customer__city)"/>
        <postfield name="customer__state" value="$(customer__state)"/>
        <postfield name="customer__zip" value="$(customer__zip)"/>
        <postfield name="customer__phone_number" value="$(customer__phone_number)"/>
    </go>
  </do>

</card>

<% End if %>

</wml>
